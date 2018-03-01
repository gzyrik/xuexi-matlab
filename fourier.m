function Y=fourier()
%傅里叶变换
N=1000;
k=-N:N;
W1=40;
W=k*W1/N;
F=f1*exp(-j*t'*W)*R;               %f1的傅里叶变换
