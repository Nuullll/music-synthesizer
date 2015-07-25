function f = detect_fundamental_f(slice,fs)
% f = detect_fundamental_f(slice,fs)
%输入:
%   <column vector> slice: 音乐片段
%   <float> fs: 采样率
%输出:
%   <row vector> f: 所有可能的基频
%% test
slice = fmt(l+1:2*l);

%% autocorr
N = length(slice);
acf = xcorr(slice);     % auto corr function
figure(1);
subplot(2,1,1);plot(slice);title('slice');
subplot(2,1,2);plot(acf);title('acf');
figure(2);fft_plot(slice,fs);
maxs = find(diff(sign(diff(acf)))==-2)+1;   % find local maximums of acf
period_length = maxs(find(maxs>N,1)) - N;   % estimate length of each period
periods = ceil(N/period_length);    % estimate numbers of period

%% preprocess
y = resample(slice,periods*period_length,N);
figure(3);plot(y,'r');hold on;plot(slice,'k');

A = reshape(y,period_length,periods).';
p = mean(A).';
w = repmat(p,periods,1);
w = resample(w,N,periods*period_length);
plot(w,'b');legend('slice','slice(resampled)','mean');

end
