% src/soundsong.m

function wav = soundsong(BPM,key,flag,song,fs)
% soundsong(BPM,key,song,fs)
% ����:
%   <float> BPM: beats per minute
%   <char> key: �����ĵ�
%   <int> flag: -1��ʾ���������(?), 1��ʾ���������(?)
%   <n-by-2 matrix> song: ����, ��һ��Ϊ��������, �ڶ���Ϊ��������������
%       ��ֹ�����ַ�'-'��ʾ
%   <float> fs: ����Ƶ��
% ����ֵ:
%   <row vector> wav: �ϳɵĸ���

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