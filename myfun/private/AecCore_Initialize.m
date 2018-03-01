function S = AecCore_Initialize(S)
%初始化回声消除过程的内部变量
if isnan(S.N) | isnan(S.M) | isnan(S.NLP) | isnan(S.fs)
    error('must set N,M,fs,NLP')
end
%S.fs   = nan;%采样频率
%S.N    = 64; %每次处理的采样个数
%--------------- 远端参考信号的相关变量
S.xBuf  = zeros(2*S.N,1);%最近的两组远端信号
S.xfBuf = zeros(S.N+1,S.M);%最近的M个远端频谱,每列都为远端频谱
S.xfwBuf= S.xfBuf;%最近的M个远端(加窗后)频谱,每列都为(加窗后)远端频谱
S.xPow  = zeros(S.N+1,1);%平滑的远端功率谱

%--------------- NLMS 变量
%S.M    = 36; %NLMS 阶数
%自适应滤波系数,每行作S.xfBuf中(M个抽头/最近M组)对应分量的权重系数
S.wfBuf = S.xfBuf;

%--------------- 近端参考信号的相关变量
S.dBuf  = S.xBuf;%最近的两组近端信号
S.dPow  = S.xPow;%平滑的近端功率谱

%--------------- 误差估计信号(本地语音)的相关变量
S.eBuf  = S.xBuf;%最近的两组误差信号

%TODO
S.outBuf=zeros(S.N,1);
%功率谱
S.se=S.xPow; S.sde=S.se; S.sxd=S.se;
%To prevent numerical instability in the first block.
S.sd=ones(S.N+1,1);S.sx=S.sd;

%S.NLP  = 1;%非线性滤波级别
S.delayIdx=1;
S.delayEstCtr=0;
S.divergeState=0;
S.hNlFbLocalMin=1;
S.hNlXdAvgMin=1;
S.hNlFbMin = 1;
S.hNlNewMin = 0;
S.hNlMinCtr = 0;
S.overDrive = 2;
S.overDriveSm = 2;
if S.fs == 32000
    S.mult = S.fs/16000;
else
    S.mult = S.fs/8000;
end
if S.fs == 8000
    S.mu = 0.6;
    S.errThresh = 2e-6;
else
    S.mu = 0.5;
    S.errThresh = 1.5e-6;
end
