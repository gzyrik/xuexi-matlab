function f=TimeToFrequency(s,w)
% 快速傅氏变换,时域采样值到频域
%   s 采样值
%   w 采样加窗
% 返回
%   f 半频谱,复数,长度为s的一半+1
%
if nargin > 1 & w
    sqrtHanning=[0;sqrt(hanning(length(s)-1))];%在sqrtHanning[N+1]==1,且以此为中心对称
    f = fft(s.*sqrtHanning);
else
    f = fft(s);
end
%因为f(2:2N)非直流分量是对称的,去掉多余的对称分量
f= f(1:end/2+1, :);
%------------对应C层代码
% aec_rdft_forward_128(float fft[128])
% fft 输入128个采样, 输出65个复数,采用SCALE
% 例如:
%   aec_rdft_forward_128(fft);
%   xf[2][65];//xf[0]为实部,xf[1]为虚部
%   xf[1][0] = 0;
%   xf[1][64] = 0;
%   xf[0][0] = fft[0]; //xf[0][0],xf[0][64]为直流分量.
%   xf[0][64] = fft[1];
%   for (i = 1; i < 64; i++) {
%       xf[0][i] = fft[2 * i];
%       xf[1][i] = fft[2 * i + 1];
%   }

