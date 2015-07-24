%% Read wav from file
fmt = wavread('G:\Vone\Tsinghua\2015summer\matlab\音乐合成\音乐合成所需资源\fmt.wav');

%% Delete mute slice
Ath = 1e-3;         % -60dB
music_begin = find(fmt>Ath,1);
music_stop = find(fmt>Ath,1,'last');
fmt = fmt(music_begin:music_stop);