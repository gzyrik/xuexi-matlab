function poles=GetFreqPole(freq,amplitude)
%将频谱freq 分三段,分别求最小是大值.
%返回7维列向量
%[scaled_amplitude;minI;maxI;minI;maxI;minI;maxI;]
V = freq.*conj(freq);
PART_LEN=length(V);
firstP  =floor(PART_LEN/3);
secondP =floor(PART_LEN*2/3);

poles = [amplitude;
getMaxMin(V(1:firstP-1));
getMaxMin(V(firstP:secondP));
getMaxMin(V(secondP:end))];

function ret=getMaxMin(v)
ret = [min(v);max(v)];
