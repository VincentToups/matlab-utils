function epsshow(in)
% On linux spawns EPS viewer.

if ~exist('in')
    d = dir('*.eps');
else
    d = dir(in);
end

d = {d(:).name};

for i=1:length(d)
    eval(['!gv ' d{i} ' &']);
end

