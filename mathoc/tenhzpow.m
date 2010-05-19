function n=tenhzpow(sig,fs)
%
%


sig = bandpass(sig,[9 11],fs);
n = std(sig);

