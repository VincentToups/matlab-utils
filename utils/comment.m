function comment(varargin)
s = '';
for ss=varargin
    s = [s ss{1} ' '];
end

eval(sprintf('!echo %s >> comments.txt',s));

