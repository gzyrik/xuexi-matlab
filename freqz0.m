%如下三种方式相同
%
%
N=64;
x=rectwin(31);
%画振幅和相位图
freqz(x,1,N);

%
%计算频谱和各分量角频率
%[h,w]=freqz(x,1,N);%等价如下计算
h = fft(x,N*2);
h = h(1:N);
w = linspace(0,pi-pi/N,N);

figure;
%画振幅图
subplot(211);
plot(w/pi,abs(h))
ylabel('幅度(dB)')
xlabel('归一化频率(\times\pi rad/sample)')
grid on;

%画相位图
subplot(212);
plot(w/pi,angle(h)*180/pi);
ylabel('相位(角度)')
xlabel('归一化频率(\times\pi rad/sample)')
grid on;

