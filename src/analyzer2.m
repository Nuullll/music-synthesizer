%% Read wav from file
fmt = wavread('G:\Vone\Tsinghua\2015summer\matlab\音乐合成\音乐合成所需资源\fmt.wav');
fs = 8000;

%% Spectrogram and plot
[S,F,T,P] = spectrogram(fmt, 2048, 2000, 2048, fs);

figure(1);
surf(T,F,10*log10(P),'edgecolor','none');
view(0,90);title('时频分析');xlabel('t/s');ylabel('f/Hz');
axis([0 16 0 4000]);

%% Pick out powerful frequency
[sortP,I] = sort(P,'descend');
sortf = F(I);   % column j of sortf is descend-sorted frequency at time T(j)
powerful3f = sortf(1:5,:);  % pick out 3 most powerful frequency
figure(2);
plot(T,sortf(1,:),'k');hold on;
plot(T,sortf(2,:),'r');
% plot(T,sortf(3,:),'b');
legend('1st','2nd','3rd');hold off;