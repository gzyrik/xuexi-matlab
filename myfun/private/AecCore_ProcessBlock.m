function [S,e]=AecCore_ProcessBlock(S,d,xf)
% 回声消除的NLMS 归一化最小均方自适应滤波算法 
%   S   = 过程实例
%   d   = 近端时域信号,N列向量
%   xf  = 远端频谱,N+1列向量
% ----------------------
S.dBuf=[S.dBuf([end/2+1:end]);d];%与上次合并成,2N列向量.本地语音,对应aec.dBuf
% S.xPow = 平滑远端功率谱,N+1列有效频谱能量
% df = 近端频谱,N+1列向量
% ------------------------  Power estimation
df = TimeToFrequency(S.dBuf);
far_power_spectrum = xf.* conj(xf);%远端功率谱,即模平方=abs(xf)^2;
near_power_spectrum = df.*conj(df);
S.xPow = 0.9*S.xPow + 0.1*S.M*far_power_spectrum;
S.dPow = 0.9*S.dPow + 0.1*near_power_spectrum;

%TODO Estimate noise power. Wait until dPow is more stable.

%TODO Smooth increasing noise power from zero at the start,
%     to avoid a sudden burst of comfort noise.

%TODO ProcessHowling
%S=ProcessHowling(S, far_power_spectrum, near_power_spectrum);

% NLMS - 归一化最小均方自适应滤波算法
% *** 在频域上进行,自适应滤波
% xfBuf = 缓存滤波处理范围内的远端频谱,即最近的M个xf,每列都为远端频谱, N+1xM 矩阵
% wfBuf = 自适应滤波系数矩阵,每行作为谐波频谱(M个抽头)权重系数,N+1xM 矩阵
%         即xfBuf是M个远端频谱,每行是特定谐波频谱.
%         针对最近的M个该谐波频谱进行加权求和,就是回声频谱估计.
% yf = 估计的回声信号频谱,N+1列向量.
% y  = 估计的回声信号,N列向量
% ----------------------   Filtering 
S.xfBuf = [xf,S.xfBuf(:,1:end-1)];% 所有最近M个远端谐波频谱,N+1 x M 矩阵
yf = FilterFar(S);%N+1列向量
ykt = FrequencyToTime(yf);
y = ykt(end/2+1:end);%变换前与前一次数据相结合,故本次数据在后一半 

% e = 近端信号与回声估计的误差,即消除后的声音,N列向量
% ef = 该误差的频谱,N+1列向量
% erfb = 所有回声消除后的声音信号
% ----------------------   Error estimation 
e = d - y; %实际近端信号与回声估计的误差,即本地语音

%TODO 计算误差频谱,前段为何补0, 上次误差强制为0?
ef = TimeToFrequency([zeros(size(e));e]);% FD version for cancelling part (overlap-save)

ef = ScaleErrorSignal(S, ef);
S = FilterAdaptation(S, ef);%更新权重wfBuf

%--------------------------------------------------------------------------
function yf=FilterFar(S)
%对每种M个谐波频谱,加权后,横向求和,N+1列向量.对应C函数FilterFar()
%类似同时进行N+1次的NLMS滤波
yf = sum(S.xfBuf .* S.wfBuf, 2);

%--------------------------------------------------------------------------
% NLMS 迭代公式 
%      W[k] = W[k-1] + 2pX'D = W + aX'D/(X'X+b)
% 此处 b=1e-10, X'X=S.xPow, a=S.mu
function ef=ScaleErrorSignal(S,ef)
ef = ef./(S.xPow + 1e-10);
absEf = abs(ef);
idx = find(absEf > S.errThresh);
if ~isempty(idx)
    ef(idx) = ef(idx)*S.errThresh./(absEf(idx)+1e-10);
end
ef = ef.*S.mu;

%--------------------------------------------------------------------------
function S=FilterAdaptation(S,ef)
PP = conj(S.xfBuf).*repmat(ef, 1, S.M); %xfBuf为N+1xM阵,ef为N+1列向量
%TODO ifft/fft? 为什么不将PP直接作为FPH
IFPP = FrequencyToTime(PP);%时域信号2NxM阵
IFPP(end/2+1:end,:)=0;%只取上半部分时域
FPH = TimeToFrequency(IFPP);
S.wfBuf = S.wfBuf + FPH;
