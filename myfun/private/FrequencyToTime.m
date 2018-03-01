function s=FrequencyToTime(f,w)
% 快速傅氏逆变换,频域到时域采样值
%   f 半频谱,复数
%   w 采样加窗
% 返回
%   s 采样值,长度为f的2倍-2
%
f = [f ; flipud(conj(f(2:end-1,:)))];%补全频谱,适应ifft参数要求
s = real(ifft(f));
if nargin > 1 & w
    sqrtHanning=[0;sqrt(hanning(length(s)-1))];%在sqrtHanning[N+1]==1,且以此为中心对称
    s = s.*sqrtHanning;
end
%------------对应C层代码
% aec_rdft_inverse_128(float fft[128])
% fft 输入65个复数,输出128个采样, 采用NOSCALE,结果需要手工伸缩
% 例如:
%   fft[0] = xf[0][0];
%   fft[1] = xf[0][64];
%   for (i = 1; i < 64; i++) {
%       fft[2 * i] = xf[0][i];
%       fft[2 * i + 1] = xf[1][i];
%   }
%   aec_rdft_inverse_128(fft);
%   // fft scaling
%   {
%     float scale = 2.0f / 128;
%     for (j = 0; j < 128; j++)
%       fft[j] *= scale;
%   }
