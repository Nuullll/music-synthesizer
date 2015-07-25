%% Read wav from file
fmt = wavread('G:\Vone\Tsinghua\2015summer\matlab\音乐合成\音乐合成所需资源\fmt.wav');
fs = 8000;

%% Spectrogram and plot
[S,F,T,P] = spectrogram(fmt, 2048, 2000, 4000, fs);

figure(1);
surf(T,F,10*log10(P),'edgecolor','none');
view(0,90);title('时频分析');xlabel('t/s');ylabel('f/Hz');
axis([0 16 0 4000]);

%% Sort
[sortP,I] = sort(P,'descend');
sortf = F(I);   % column j of sortf is descend-sorted frequency at time T(j)

%% 