function soundnote(key,nnote,flag,tn,fs,tp)

% sound note; note lasts for time tn, pause for time tp
t = 0:1/fs:tn;
sound(sin(2*pi*freqmap(key,nnote,flag)*t),fs);
pause(tn+tp);

end

