% src/soundsong.m

function wav = soundsong(BPM,key,flag,song,fs,ADSR)
% soundsong(BPM,key,song,fs,ADSR)
% ����:
%   <float> BPM: beats per minute
%   <char> key: �����ĵ�
%   <int> flag: -1��ʾ���������(?), 1��ʾ���������(?)
%   <n-by-2 matrix> song: ����, ��һ��Ϊ��������, �ڶ���Ϊ��������������
%       ��ֹ����-inf��ʾ
%   <float> fs: ����Ƶ��
%   <1-by-4 matrix> ADSR: adsr�������
% ����ֵ:
%   <row vector> wav: �ϳɵĸ���

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