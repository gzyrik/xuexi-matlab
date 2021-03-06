%频谱能量泄漏
% 令conv2(x,y)是卷积运算.
% <b>傅里叶变换是研究整个时间域和频率域的关系.</b> 然而,
% 当运用计算机实现工程测试信号处理时,不可能对无限长的信号进行测量和运算,而是
% <b>取其有限的时间片段进行分析</b>
% 做法是从信号中截取一个时间片段,然后用观察的信号时间片段进行
% <b>周期延拓处理.得到虚拟的无限长的信号</b>,
% 然后就可以对信号进行傅里叶变换,相关分析等数学处理.
%
% 周期延拓后的信号与真实信号是不同的.下面从数学的角度来看这种处理带来的误差情况.
% 设有
%    频率为f的余弦信号
%    x(t) = cos(f*2*pi*t)
% 在时域分布为无限长(-inf，inf), 当用矩形窗函数w(t)与其相乘时,
% 得到截断信号
%          xT(t)=x(t).*w(t).
% 根据博里叶变换关系.余弦信号的频谱X(f)是位于f处的冲激函数,而矩形窗函数w(t)的谱为sinc(f)函数.
% 按照频域卷积定理,则截断信号xT(t)的谱XT(f) 应为
%           XT(f)=conv2(X(f),W(f))/(2pi)
% 将截断信号的谱XT(f)与原始信号的谱X(f)相比较可知,它已不是原来的两条谱线,而是两段振荡的连续谱.
% 这表明原来的信号被截断以后,其频谱发生了畸变,原来集中在f处的能量被分散到两个较宽的频带中去了,
% 这种现象称之为频谱能量泄漏(Leakage).
%
% 如果增大截断长度T,即矩形窗口加宽,则窗谱sinc(f)将被压缩变窄(pi／T减小).虽然理论上讲,其频谱范围仍为无限宽,
% 但实际上中心频率以外的频率分量衰减较快,因而泄漏误差将减小.当窗口宽度T趋于无穷大时,则谱窗sinc(f)将变为冲激函数,
% 与X(f)的卷积仍为X(f),这说明,如果窗口无限宽,即不截断,就不存在泄漏误差.
%

%余弦信号,时域分布L
L=512;
fs=100;
t=[0:L-1]'/fs;
x=cos(2*pi*15*t);%15Hz
X=fft(x);

%矩形窗函数,时间片段 T 远小于 L
T=100;
w=zeros(L,1);
%w(1:T-1)=1;
w(1:T)=hanning(T);
W=fft(w);
XT=fft(x.*w);
%作图
t = (-L/2:L/2-1)*(fs/L);% 横坐标为中心对齐的频率
plot(t, real(fftshift([X W XT])));

% 频域卷积定理
%   设有信号x(t),w(t),对应的频谱X(f),W(f),则有
%            x(t).*w(t) 的频谱 =  conv(X(f),W(f))/(2pi)
%Y=fftshift(abs(conv2(fft(x),fft(y))/(2*pi)));

% 时域卷积定理
%   设有信号x(t),y(t),对应的频谱X(f),Y(f),则有
%        conv(x(t),y(t) 的频谱 = X(f) .* Y(f)
%abs(fft(conv2(x,y)));
%abs(fft(x).*fft(y));
