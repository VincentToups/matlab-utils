function n=hostname()
%
%

[s,n] = system('hostname');
ii = find(newline==n);
n = n(1:ii(1));
n = strrep(n,newline,'');

%e% hostname

