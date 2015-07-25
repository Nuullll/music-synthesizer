function fft_plot(y,fs)
%plot F(omg)

N = length(y);
n = 0:N-1;
% t = n/fs;
f = n/N*fs;
plot(f,abs(fft(y)));

end

