function shift=shiftup(fig,grace)
% This function finds the highest element in a figure and shifts the whole thing up 
%  so that it is square with the top of the figure.

if ~exist('grace')
    grace = 0;
end

set(fig,'Units','normalized');

cc = get(fig, 'Children');
cc
ps = [];
for h=cc'
    try
        h
        p = get(h,'Position')

        ps = [ps; p];
    catch
        nothing = 10;
    end
end

if isempty(ps)
    shift = 0;
    warning(sprintf('Hmm, this figure (%d) is empty.',fig));
    return
end

heights = ps(:,2)+ps(:,4);
mh = max(heights)
shift = 1-mh+grace;
for h=cc'
    try
        p = get(h,'Position');
        p(2) = p(2) + shift;
        set(h,'Position',p);
    end
end

