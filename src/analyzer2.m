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

funds = cell(size(sortf,2),1);  % to save fundamental results

for i = 1:size(sortf,2)
    fundamental = [];
    col = sortP(:,i);
    if max(col)>Pth2
        f = sortf(1:5,i);
    else
        f = [];
    end
    if isempty(f)
        f = sortf((col>Pth2));
        if isempty(f)
            f = [];
        end
    end
   
    fundamental = ffilter(f);   % detect fundamental component
    % fundamental may equals [1312,656], as f is power-sorted
    % so we must sort fundamental and ffilter again
    fundamental = ffilter(sort(fundamental,'ascend'));
    
    funds{i} = fundamental;
end

%% Map to note
ns = cell(length(T),1);

for i = 1:length(T)
    ns{i} = round(12*log2(funds{i}/220));
end

%% Resolution
resolution = 0.15;
combo = round(resolution/(T(2)-T(1)));
for i = 2:length(T)-combo
    if ~isequal(ns{i},ns{i-1}) && ~isequal(ns{i},ns{i+combo})
        ns{i} = ns{i-1};
    end
end
% for i = length(T)-combo+1:length(T)
%     ns{i} = ns{length(T)-combo+1};
% end

%% Calculate time
nt = cell(1,2);
nt{1,1} = ns{1}; nt{1,2} = T(1);

for i = 2:length(T)
    if isequal(ns{i},nt{end,1}) || isequal(ns{i},[])
        nt{end,2} = T(i);
    else
        nt = [nt;cell(1,2)];
        nt{end,1} = ns{i}; nt{end,2} = T(i);
    end
end

for i = 1:size(nt,1)-1
    nt{end-i+1,2} = nt{end-i+1,2} - nt{end-i,2};
end


%% test
wav = [];
for i = 1:size(nt,1)
    t = 0:1/fs:nt{i,2};
    w = zeros(1,length(t));
    for j = 1:length(nt{i,1})
        if nt{i,1}(j) > 12
            n = nt{i,1}(j) - 12;
        else
            n = nt{i,1}(j);
        end
        f = 220*2^(n/12);
        w = w + adsr(0.14,0.26,0.45,0.26,sin(2*pi*f*t)+0.3*sin(4*pi*f*t),t);
    end
    wav = [wav,w];
end
wav = wav/max(wav);
figure;subplot(2,1,1);plot(fmt);
subplot(2,1,2);plot(wav);
sound(wav,fs);
