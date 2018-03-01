%LMS使用示例
% 最小均方自适应滤波算法,以输入的统计特性自动调整滤波,使其接近期望

%周期信号的产生
N=128;
M=16;%滤波器的阶数
t=1:N;
xn=sin(0.5*t);%输入的远端参考信号
yn=rand*xn;%与远端线程相关的回声
en=0.5*cos(3*t)+0.4*sin(7*t+30);%本地语音信号
dn=yn+en; %期望的近端输入信号(回声+本地语音+环境噪声)
%已知远端参考信号xn和近端输入信号dn,求本地语音信号en的最优估计

%lms
S1=LeastMeanSquare;
S1.M=M;
%选取收敛因子
S1.p=rand/max(eig(xn.'*xn)); %输入信号相关矩阵的最大特征值的倒数

%NLMS 修正步长=0.1
S2=LeastMeanSquare;
S2.M=M;
S2.p=[0.1,0.0001];

%NLMS 修正步长=0.2
S3=LeastMeanSquare;
S3.M=M;
S3.p=[0.2,0.0001];

%迭代滤波
y1=[];y2=[];y3=[];
e1=[];e2=[];e3=[];
for i=1:N
    [S1,y1(end+1),e1(end+1)]=LeastMeanSquare(S1,xn(i),dn(i));
    [S2,y2(end+1),e2(end+1)]=LeastMeanSquare(S2,xn(i),dn(i));
    [S3,y3(end+1),e3(end+1)]=LeastMeanSquare(S3,xn(i),dn(i));
end

%作图
figure;
plot(t,en-e1,'r', t,en-e2,'g', t, en-e3,'k');
title('误差: 红线=LMS,绿线=NLMS(0.1),黑色=NLMS(0.2)')
