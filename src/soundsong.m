% src/soundsong.m

function wav = soundsong(BPM,key,flag,song,fs)
% soundsong(BPM,key,song,fs)
% 输入:
%   <float> BPM: beats per minute
%   <char> key: 歌曲的调
%   <int> flag: -1表示降半个音阶(?), 1表示升半个音阶(?)
%   <n-by-2 matrix> song: 乐谱, 第一列为音符唱名, 第二列为各音符持续拍数
%       休止符用字符'-'表示
%   <float> fs: 采样频率
% 返回值:
%   <row vector> wav: 合成的歌曲

tpb = 60/BPM;   % time per beat (seconds)
wav = [];       % intialize wav
for i = 1:size(song,1)
    t = 0:1/fs:(tpb*song(i,2));     % time sequence
    if song(i,1) == '-'
        wav = [wav, zeros(1,length(t))];
    else
        wav = [wav, sin(2*pi*freqmap(key,song(i,1),flag)*t)];
    end
end

sound(wav,fs);

end