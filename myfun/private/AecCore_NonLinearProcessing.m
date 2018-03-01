function [S,e]=AecCore_NonLinearProcessing(S,e,xfw)
% 回声消除中非线性滤波
%  S    = 回声消除对象
%  e    = 估计的本地语音,误差信号
%  xfw  = 远端加窗频谱,N+1列向量
% 返回回声消除过程对象和处理后的声音

%与上次合并成,2N列向量.本地语音,对应aec.eBuf
S.eBuf = [S.eBuf([end/2+1:end]);e]; 

% ------------------------
% xfw = 远端加窗频谱
% dfw = 近端加窗频谱
% efw = 误差加窗频谱
% xfwBuf = 缓存滤波处理范围内的远端频谱,即最近的M个xfw,每列都为远端频谱, N+1xM 矩阵
S.xfwBuf=[xfw, S.xfwBuf(:,1:end-1)];

%加窗,减少频谱能量泄漏.
dfw = TimeToFrequency(S.dBuf,true);
efw = TimeToFrequency(S.eBuf,true);
% ------------------------
%TODO 为什么间隔 10*S.mult, 间隔80 ms
% 8kHz时,每次处理 S.M/8=8 ms时长数据.
S.delayEstCtr = S.delayEstCtr+1;
if S.delayEstCtr == 10 * S.mult
    S.delayEstCtr = 0;
    % xfw和dfw的简单对齐算法. 由LMS原理得
    % 系数矩阵中权重最大列,可以认为对应着,当前参考信号
    wfEn = sum(S.wfBuf.*conj(S.wfBuf));%系数阵能量,即模平方=abs(WFb)^2
    [wfEnMax, S.delayIdx] = max(wfEn);%wfEnMax为最大能量,delayIdx为所在序号
end
xfw = S.xfwBuf(:,S.delayIdx);%使用简单对齐后的远端加窗频谱

% ---------- Power estimate smoothing
% .sd = 近端功率谱
% .se = 误差功率谱
% .sx = 远端功率谱
% sdSum = 近端功率
% seSum = 误差功率
gCoh = [0.9, 0.1;0.93, 0.07];
gamma = gCoh(S.mult, :);%平滑系数
% Smoothed PSD
S.sd  = gamma(1)*S.sd  + gamma(2)*(dfw.*conj(dfw));
S.se  = gamma(1)*S.se  + gamma(2)*(efw.*conj(efw));
% We threshold here to protect against the ill-effects of a zero farend.
% The threshold is not arbitrarily chosen, but balances protection and
% adverse interaction with the algorithm's tuning.
% TODO: investigate further why this is so sensitive.
S.sx  = gamma(1)*S.sx  + gamma(2)*max(xfw.*conj(xfw),15);
S.sde = gamma(1)*S.sde + gamma(2)*efw.*conj(dfw);
S.sxd = gamma(1)*S.sxd + gamma(2)*xfw.*conj(dfw);
sdSum = sum(S.sd);
seSum = sum(S.se);

% ---------- Divergent filter safeguard(发散保护)
% .divergeState  = 回声消除是否发散
if S.divergeState == 0
    % 误差功率(seSum) > 近端功率(sdSum)时,认为发散
    if seSum > sdSum; S.divergeState = 1; end
else
    if seSum*1.05 < sdSum;  S.divergeState = 0; end
end
% 若发散了,直接使用近端语音.
if S.divergeState == 1; efw = dfw; end

% Reset if error is significantly larger than nearend (13 dB).
if seSum > sdSum*19.95; S.wfBuf=zeros(size(S.wfBuf)); end % Block-based FD NLMS
% ------------------------ 常量
targetSupp = [-6.9, -11.5, -11.5]; %-6.9f, -11.5f, -18.4f
minOverDrive = [1.0, 3.0, 5.0];
PREF_BAND_SIZE = 24;
prefBandQuant = 0.75;
prefBandQuantLow = 0.5;
prefBandSize = PREF_BAND_SIZE / S.mult;
minPrefBand  = 4 / S.mult + 1;
maxPrefBand  = minPrefBand + prefBandSize-1;

% ---------- Subband coherence(一致性)
% cohde = 误差与近端相关谱,值越大,回声越小
% cohxd = 远端与近端相关谱,值越大,回声越大
% 都为N+1列向量,范围在[0,1]
% 相关性计算公式: (a.*b)^2/ (a^2 .* b^2)
cohde = S.sde.*conj(S.sde)./(S.se.*S.sd + 1e-10);
cohxd = S.sxd.*conj(S.sxd)./(S.sx.*S.sd + 1e-10);

%-----------
% hNlDeAvg = 为误差近端相关性均值,越大越好
% hNlXdAvg = 为远端近端不相关性均值,越大越好.
% 都为N+1列向量,范围在[0,1]
% 均值计算都选取了部分频率[minPrefBand:maxPrefBand]
% 根据FFT性质,子频i,对应频率 2(i-1)/N * fs, 故
%   minPrefBand->8/64*fs/S.mult=8k/8=1k
%   maxPrefBand->56/64*fs/S.mult=7k
% 所以, 8kHz和16kHz时,都选取[1k,7k]Hz
% 注意普通人能听到的最大范围[20,20k]Hz
hNlDeAvg = sum(cohde(minPrefBand:maxPrefBand))/prefBandSize;
hNlXdAvg = 1 - sum(cohxd(minPrefBand:maxPrefBand))/prefBandSize;


% .hNlXdAvgMin = hNlXdAvg的最小值,自动逐渐增大并被修正
if hNlXdAvg < 0.75 & hNlXdAvg < S.hNlXdAvgMin
    S.hNlXdAvgMin = hNlXdAvg;
end

% .stNearState = 是否只有近端信号
if hNlDeAvg > 0.98 & hNlXdAvg > 0.9 %误差/近端高度相关,远端/近端高度不相关
    S.stNearState = 1;
elseif hNlDeAvg < 0.95 | hNlXdAvg < 0.8
    S.stNearState = 0;
end

%-----------
% .echoState = 是否存在回声
% hNl = 误差与近端相关性cohde,近端与远端不相关性(1 - cohxd),其中较小的值
% hNlFb = hNl的最大阀值
% hNlFbLow = hNl中的最小阀值
if S.hNlXdAvgMin == 1  %远端近端不相关,即没有回声
    %初始化首次进入
    S.echoState = 0;
    S.overDrive = minOverDrive(S.NLP);
   if S.stNearState == 1
       hNl = cohde;
       hNlFb = hNlDeAvg;
       hNlFbLow = hNlDeAvg;
    else
       hNl = 1 - cohxd;
       hNlFb = hNlXdAvg;
       hNlFbLow = hNlXdAvg;
    end
else % hNlXdAvgMin != 1
    if S.stNearState == 1 % 都是近端信号
       S.echoState = 0;
       hNl = cohde;
       hNlFb = hNlDeAvg;
       hNlFbLow = hNlDeAvg;
    else
       S.echoState = 1;
       hNl = min(cohde, 1-cohxd);
       %Select an order statistic from the preferred bands.
       %子带的相关性排序
       hNlPref = sort(hNl(minPrefBand:minPrefBand+prefBandSize));
       hNlFb = hNlPref(floor(prefBandQuant * prefBandSize));
       hNlFbLow = hNlPref(floor(prefBandQuantLow * prefBandSize));
    end
end %hNlXdAvgMin == 1


%TODO 为什么逐渐增大.hNlXdAvgMin(越大越好)
S.hNlXdAvgMin = min(S.hNlXdAvgMin + 0.0006 / S.mult, 1);

%-----------
% Track the local filter minimum to determine suppression overdrive.
% .hNlFbLocalMin = hNlFbLow的最小值(越大越好), 自动逐渐增大并被修正
if hNlFbLow < 0.6 & hNlFbLow < S.hNlFbLocalMin
    % 误差与近端的相关性变小,出现回声的可能性很大
    S.hNlFbLocalMin = hNlFbLow;
    S.hNlFbMin = hNlFbLow;
    S.hNlNewMin = true;%进入计数状态
    S.hNlMinCtr = 0;%计数清0
end
%TODO 为什么逐渐增大.hNlFbLocalMin
S.hNlFbLocalMin = min(S.hNlFbLocalMin + 0.0008 / S.mult, 1);

if S.hNlNewMin
    S.hNlMinCtr = S.hNlMinCtr+1;
    if S.hNlMinCtr == 2 %到计数达2时,复位
        S.hNlNewMin = 0;
        S.hNlMinCtr = 0;
        %TODO 为什么要计数,达到延时计算.overDrive 的目的
        S.overDrive = max(targetSupp(S.NLP)/(log(S.hNlFbMin + 1e-10) + 1e-10), minOverDrive(S.NLP));
    end
end

%-----------
% Smooth the overdrive.
if S.overDrive < S.overDriveSm
    S.overDriveSm = 0.99 * S.overDriveSm + 0.01 * S.overDrive;
else
    S.overDriveSm = 0.9 * S.overDriveSm + 0.1 * S.overDrive;
end
efw = OverdriveAndSuppress(S, hNl, hNlFb, efw);

% Overlap and add to obtain output.
tmp = FrequencyToTime(efw, true);
e = tmp(1:end/2) + S.outBuf;
S.outBuf = tmp(end/2+1:end);
%--------------------------------------------------------------------------
%超频抑制
function [efw,hNl]=OverdriveAndSuppress(S, hNl, hNlFb, efw)
% hNl = 误差与近端相关谱,[0,1]
% hNlFb = 阀值
% efw = 
%  .overDriveSm
% ------------------------ 常量
weightCurve = [0 ; 0.3 * sqrt(linspace(0,1,64))' + 0.1]; %超过阀值的权重谱, 用于限制过大值
overDriveCurve = [sqrt(linspace(0,1,65))' + 1]; %超频幂指数谱

idx = find(hNl > hNlFb);
if ~isempty(idx)
    % hNl中超过 hNlFb的值,将用S.weightCurve进行加权
    % 目的:  线性降低所有超过阀值的值.
    hNl(idx) = weightCurve(idx).*hNlFb + (1-weightCurve(idx)).*hNl(idx);
end
%
hNl = hNl.^(S.overDriveSm * overDriveCurve);
%频域点乘相当于时域卷积,这相当于误差信号通过了传递函数为hNl的滤波器
efw = efw .* hNl;
