function [S,e] = EchoCancellation(S,x,d)
%回声消除的消除过程
% 回声消除可分成的对齐过程和消除过程
% 对近端信号进行回声消除,假设x与d在时序上已对齐
%   S   = 过程实例
%   x   = 远端时域信号,N列向量
%   d   = 近端时域信号,N列向量
% 返回该过程对象,消除后的误差信号(即本地语音)
%初始化配置参数
%   S.fs 信号采样频率
%   S.N  每次处理的采样个数
%   S.M  NLMS 阶数
%   S.NLP 非线性滤波级别[1,3]
if nargin == 0 %创建对象
    if nargout > 1; error('Redundant output parameters'); end
    %默认的配置参数
    S.fs = nan; S.N = 64; S.M=36; S.NLP = 1; 
    %动态变量
    S.xfwBuf = nan;
    return;
elseif nargin < 3
    error('Insufficient input parameters')
end

%初始化
if isnan(S.xfwBuf); S = AecCore_Initialize(S); end

%计算远端频谱
S.xBuf=[S.xBuf([end/2+1:end]);x];%与上次合并成,2N列向量
xf = TimeToFrequency(S.xBuf); %远端频谱,N+1列向量
xfw= TimeToFrequency(S.xBuf, true);%远端加窗频谱,N+1列向量

%估计误差
[S,e] = AecCore_ProcessBlock(S, d, xf);

%非线性滤波
[S,e] = AecCore_NonLinearProcessing(S, e, xfw);

% 术语
% amplitude 振幅
% power     功率
