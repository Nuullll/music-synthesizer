function f = detect_fundamental_f(slice,fs)
% f = detect_fundamental_f(slice,fs)
%输入:
%   <column vector> slice: 音乐片段
%   <float> fs: 采样率
%输出:
%   <row vector> f: 所有可能的基频
%% test
% l = 5000;
% r = randi(length(fmt),1,1);
% slice = fmt(r:r+l-1);

%% autocorr
N = length(slice);
acf = xcorr(slice);     % auto corr function
figure(1);
subplot(2,1,1);plot(slice);title('slice');
subplot(2,1,2);plot(acf);title('acf');
maxs = find(diff(sign(diff(acf)))==-2)+1;   % find local maximums of acf
maxs = maxs(acf(maxs)>acf(N)/2);
period_length = (maxs(find(maxs>N,1))-N); % estimate length of each period
if isempty(period_length)
    f = [];return;
end
periods = ceil(N/period_length);    % estimate numbers of period

%% preprocess
y = resample(slice,periods*period_length,N);
figure(3);plot(y,'r');hold on;plot(slice,'k');

A = reshape(y,period_length,periods).';
p = mean(A).';
w = repmat(p,periods,1);
w = resample(w,N,periods*period_length);
plot(w,'b');legend('slice','slice(resampled)','mean');hold off;

%% pick out powerful frequency
figure(2);
subplot(2,1,1);fft_plot(slice,fs);title('原片段频谱');xlabel('f/Hz');
subplot(2,1,2);fft_plot(repmat(w,100,1),fs);title('平均除噪后频谱');xlabel('f/Hz');
y = abs(fft(repmat(w,100,1)));
E = 100;                % threshold of E
f = find(y>E)*fs/N/100; % pick out powerful frequency
f = f(1:end/2);         % delete symmetry elements

%% detect fundamental frequency
fundamental = [];
for i = 1:length(f)
    if isempty(fundamental)
        fundamental = [fundamental,f(i)];
    else
        ratio = f(i)./fundamental;
        inrange = (ratio<(round(ratio)*1.005)) + (ratio>(round(ratio)*0.995));
        if all(inrange~=2)
            fundamental = [fundamental,f(i)];
        end
    end
end

f = fundamental;

end
