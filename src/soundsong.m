% src/soundsong.m

function wav = soundsong(BPM,key,flag,song,fs,ADSR)
% soundsong(BPM,key,song,fs,ADSR)
% 输入:
%   <float> BPM: beats per minute
%   <char> key: 歌曲的调
%   <int> flag: -1表示降半个音阶(?), 1表示升半个音阶(?)
%   <n-by-2 matrix> song: 乐谱, 第一列为音符唱名, 第二列为各音符持续拍数
%       休止符用-inf表示
%   <float> fs: 采样频率
%   <1-by-4 matrix> ADSR: adsr包络控制
% 返回值:
%   <row vector> wav: 合成的歌曲

tpb = 60/BPM;   % time per beat (seconds)
wav = [];       % intialize wav

attack = ADSR(1);
decay = ADSR(2);
sustain = ADSR(3);
release = ADSR(4);

for i = 1:size(song,1)
    t = 0:1/fs:(tpb*song(i,2));     % time sequence
    if song(i,1) == -inf
        wav = [wav, zeros(1,length(t))];
    else
        wav = [wav, adsr(attack,decay,sustain,release,...
            sin(2*pi*freqmap(key,song(i,1),flag)*t),t)];
    end
end

sound(wav,fs);

end