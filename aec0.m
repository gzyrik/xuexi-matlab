%测试数据集
format long
fs_list=[8000;16000;16000];
dir_list=['pcm/g7_voice_06/';'pcm/my_voice_01/';'pcm/my_voice_02/';];
test=1;
%-----------------------
%读取信号数据为列向量
% rrin = 远端信号
% ssin = 近端信号
%-----------------------
dir=dir_list(test, :);
fs=fs_list(test);
fid=fopen([dir 'farend.pcm'], 'rb');
rrin=fread(fid,inf,'int16');
fclose(fid);

fid=fopen([dir 'aec_near.pcm'], 'rb');
ssin=fread(fid,inf,'int16');
fclose(fid);

%每次取64个采样与上次一并处理,64*2个采样值,FFT后得到有效频谱(65个分量振幅)
% N  = 每次处理采样个数
% Nb = 总共处理次数
% M  = 最近36个频谱,作为NLMS算法抽头,NLMS的阶数
%-----------------------
N=64;
M=36;
len=length(ssin);
Nb=floor(len/N)-M; %处理次数
%-----------------------
S = EchoCancellation;
S.N=N;
S.M=M;
S.fs=fs;
S.NLP=1;
%-----------------------
fid = fopen([dir 'aecOut.pcm'], 'wb');
for kk=1:Nb
    pos = N * (kk-1) + 1;
    [S,r] = EchoCancellation(S,rrin(pos:pos+N-1), ssin(pos:pos+N-1));
    fwrite(fid, r, 'int16');  
end
fclose(fid);
