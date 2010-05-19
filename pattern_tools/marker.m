function s = marker(i)
%
%

markers = 'ox+*sdv^<>ph';
s = markers(1+mod(i,length(markers)));

