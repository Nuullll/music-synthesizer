%% Read wav from file
fmt = wavread('G:\Vone\Tsinghua\2015summer\matlab\音乐合成\音乐合成所需资源\fmt.wav');
fs = 8000;

%% Delete mute slice
Ath = 1e-3;         % -60dB
music_begin = find(fmt>Ath,1);
music_stop = find(fmt>Ath,1,'last');
fmt = fmt(music_begin:music_stop);

%% Processing slices
l = 200;    % length of each slice
note = [];
for i = 1:floor(length(fmt)/l)
    note = [note,detect_fundamental_f(fmt((i-1)*l+1:i*l),fs)];
end
