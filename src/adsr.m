function wav = adsr(attack,decay,sustain,release,wavin,t)
%wav = adsr(attack,decay,sustain,release,generator,t)
% 输入:
%   <float> attack: 冲激时间所占比例
%   <float> decay: 衰减时间所占比例
%   <float> sustain: 延音电平归一化振幅(最大振幅为1)
%   <float> release: 释放时间所占比例
%   <string> generator: 'sin', 'sawtooth', 'square'
%   <row vector> t: 时间序列
%   <float> f: 频率
% 返回值:
%   <row vector> wav: 包络调制后的波形

N = length(t);
ta = t(1:floor(attack*N));     % time sequence for Attack
td = t(floor(attack*N)+1:floor((attack+decay)*N));    % time sequence for Decay
tr = t(floor((1-release)*N)+1:end);    % time sequence for Release

wa = wavin(1:floor(attack*N));
wd = wavin(floor(attack*N)+1:floor((attack+decay)*N));
ws = wavin(floor((attack+decay)*N)+1:floor((1-release)*N));
wr = wavin(floor((1-release)*N)+1:end);

ea = (1-10.^(-ta))/(1-10.^(-ta(end)));    % envelope for Attack
ed = (1-sustain)*(exp(-(td-td(end)))-1)/(exp(-(td(1)-td(end)))-1)+sustain;  % envelope for Decay
es = sustain;            % envelope for Sustain
er = sustain*...
    (10.^(sustain-(tr-tr(1))/(tr(end)-tr(1))*sustain)-1)/...
    (10.^sustain-1);    % envelope for Release

wav = [ea.*wa, ed.*wd, es.*ws, er.*wr];

end