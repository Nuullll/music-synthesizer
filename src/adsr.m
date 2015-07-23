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
ta = t(1:attack*N);     % time sequence for Attack
td = t(attack*N+1:(attack+decay)*N);    % time sequence for Decay
% ts = t((attack+decay)*N+1:(1-release)*N);   % time sequence for Sustain
tr = t((1-release)*N+1:end);    % time sequence for Release

wa = wavin(1:attack*N);
wd = wavin(attack*N+1:(attack+decay)*N);
ws = wavin((attack+decay)*N+1:(1-release)*N);
wr = wavin((1-release)*N+1:end);

ea = exp(ta/ta(end))/exp(1);    % envelope for Attack
ed = exp(1-(td-td(1))/(td(end)-td(1))*(1-sustain))/exp(1);  % envelope for Decay
es = exp(sustain)/exp(1);            % envelope for Sustain
er = exp(sustain-(tr-tr(1))/(tr(end)-tr(1))*sustain)/exp(1);    % envelope for Release

wav = [ea.*wa, ed.*wd, es.*ws, er.*wr];

end

