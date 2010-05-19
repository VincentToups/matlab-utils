function words = vb2h(w)
% VB2H converts words to HEX strings.
% WORDS = VB2H(W) takes a set of binary words W and (word by digit)
% and returns a set of hexidecimal strings representing them.
% 
% Code borrowed from Boolean Algebra Toolbox, Rasmus Anthin
%
% http://www.mathworks.com/matlabcentral/fileexchange/loadFile.do?objectId=2787&objectType=FILE
%

%Old
n = size(w,2);
nn = ceil(n/4)*4;
if nn > n
    w(1,nn) = 0;
elseif nn < n
    disp('Something WEIRD');
    keyboard
end

str = ['{ ' sprintf(['b2h([' repmat('%d ',[1 nn]) ']) '], w') '}'];
eval(['words = ' str ';']);

