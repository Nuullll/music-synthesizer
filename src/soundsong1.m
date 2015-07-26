% src/soundsong1.m

function wav = soundsong1(BPM,key,flag,song,fs,ADSR,har)
% soundsong(BPM,key,song,fs,ADSR,harmonics)
% ����:
%   <float> BPM: beats per minute
%   <char> key: �����ĵ�
%   <int> flag: -1��ʾ���������(?), 1��ʾ���������(?)
%   <n-by-2 matrix> song: ����, ��һ��Ϊ��������, �ڶ���Ϊ��������������
%       ��ֹ����-inf��ʾ
%   <float> fs: ����Ƶ��
%   <1-by-4 matrix> ADSR: adsr�������
%   <containers.Map> har: ������Ӧ����г����������
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
    f = freqmap(key,song(i,1),flag);
    if ~isKey(har,song(i,1))
        harmonics = [1];    % default
    else
        harmonics = har(song(i,1));
    end
    w = harmonics*sin(2*pi*f*(1:length(harmonics)).'*t);  % add harmonics
    if song(i,1) == -inf
        wav = [wav, zeros(1,length(t))];
    else
        w = adsr(attack,decay,sustain,release,w,t);
        wav = [wav,w];
    end
end

wav = wav/max(wav);     % normalization

sound(wav,fs);

end