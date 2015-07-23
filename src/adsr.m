function wav = adsr(attack,decay,sustain,release,wavin,t)
%wav = adsr(attack,decay,sustain,release,generator,t)
% ����:
%   <float> attack: �弤ʱ����ռ����
%   <float> decay: ˥��ʱ����ռ����
%   <float> sustain: ������ƽ��һ�����(������Ϊ1)
%   <float> release: �ͷ�ʱ����ռ����
%   <string> generator: 'sin', 'sawtooth', 'square'
%   <row vector> t: ʱ������
%   <float> f: Ƶ��
% ����ֵ:
%   <row vector> wav: ������ƺ�Ĳ���

N = length(t);
ta = t(1:floor(attack*N));     % time sequence for Attack
td = t(floor(attack*N)+1:floor((attack+decay)*N));    % time sequence for Decay
tr = t(floor((1-release)*N)+1:end);    % time sequence for Release

wa = wavin(1:floor(attack*N));
wd = wavin(floor(attack*N)+1:floor((attack+decay)*N));
ws = wavin(floor((attack+decay)*N)+1:floor((1-release)*N));
wr = wavin(floor((1-release)*N)+1:end);

ea = ta/ta(end);    % envelope for Attack
ed = 1-(td-td(1))/(td(end)-td(1))*(1-sustain);  % envelope for Decay
es = sustain;            % envelope for Sustain
er = sustain-(tr-tr(1))/(tr(end)-tr(1))*sustain;    % envelope for Release

wav = [ea.*wa, ed.*wd, es.*ws, er.*wr];

wav = exp(-t).*wav;

end