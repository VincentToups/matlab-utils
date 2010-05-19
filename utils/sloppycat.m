function r = sloppycat(a,b,d)
% R = SLOPPYCAT(A,B,D) concatenates A,B, even if they are different
% sizes, padding zeros the the smaller of the two in order to make them equal.
% Concatenation is performed along the direction specified by D, which is either
% 1 (down) or 2 (across).

if ~exist('d')
  d=1;
end

if isempty(a) & isempty(b)
    r = [];
    return;
elseif isempty(a)
    r = b;
    return;
elseif isempty(b)
    r = a;
    return;
end

lsa = length(size(a));
lsb = length(size(b));

if lsa ~= lsb
    error(sprintf('Number of dimensions of A, B must agree, yet they are %d and %d.',lsa,lsb));
end

padding = sprintf(',%d',repmat(1,lsa-2));
if strcmp(padding,',')
    padding = '';
end

if d == 1
    sa = size(a,2);
    sb = size(b,2);
   
    if sa < sb
        eval(['a(1,sb' padding ') = 0;']);
    elseif sb < sa
        eval(['b(1,sa' padding ') = 0;']);
    end
    r = [a;b];
elseif d == 2
    sa = size(a,1);
    sb = size(b,1);

    if sa < sb
        eval(['a(sb,1' padding ') = 0;']);
    elseif sb < sa
        eval(['b(sa,1' padding ') = 0;']);
    end

    r = [a b];
else
    error(sprintf('D must be 1 or 2, yet it is %d.',d));
end

        
    

