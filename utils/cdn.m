close all
p = pwd;
ii = find(p=='/');
pn = p( (ii(end)+2):end );
head = p( (ii(end)+1):(end-1) );
number = str2num(pn);
number = number + 1;
eval(sprintf('cd ../%s%d',head,number));
runme
type runme
f = dir('*.m');
for fi = 1:length(f)
    type(f(fi).name);
end

runme

