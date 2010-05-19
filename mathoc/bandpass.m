function [sig]=bandpass(sig, passband, fs)
%
%

sig = sig(:)';

passband = passband*2/fs;
[Bb, Ab ] = butter(4,passband);

sig = filter(Bb,Ab,sig);
%sig = fliplr(2*filter(Bb,Ab,fliplr(sig)));

