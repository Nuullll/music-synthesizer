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

%% Detect frequency
Pth1 = 1e-4;     % 1st threshold of power
Pth2 = 1e-5;     % 2nd threshold of power
Pth3 = 5e-6;     % 3rd threshold of power

funds = cell(size(sortf,2),1);  % to save fundamental results

for i = 1:size(sortf,2)
    fundamental = [];
    col = sortP(:,i);
    f = sortf((col>Pth1),i);
    if isempty(f)
        f = sortf((col>Pth2));
        if isempty(f)
            f = sortf((col>Pth3));
        end
    end
   
    for j = 1:length(f)
        if isempty(fundamental)
            fundamental = [fundamental,f(j)];
        else
            ratio = f(j)./fundamental;
            inrange = (ratio<(round(ratio)*1.05)) + (ratio>(round(ratio)*0.95));
            if all(inrange~=2)
                fundamental = [fundamental,f(j)];
            end
        end
    end
    funds{i} = fundamental;
end


