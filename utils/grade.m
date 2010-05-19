function grade(s,t)

if ~exist('t')
    t = '5';
end

pn = pwd;
ii = find(pn=='/');
pn = pn((ii(end)+1):end);

eval(sprintf('!echo "%s %s/%s" >> ../grade.txt',pn,s,t));

