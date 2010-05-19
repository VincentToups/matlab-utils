function lines=dsevt_gettriallines(dseg)
% LINES=DSEVT_GETTRIALLINES(DSEG) takes a DATASEG object for which
%  a trial clustering has been chosen and returns the lines which seperate
%  the clusterings on a rastergram.

cc = dseg.tchosen;
uns = unique(cc);
luns = length(uns);

lines = repmat(0,[1 luns]);

for i=1:luns
    lines(i) = length(find(uns(i)==cc));
end

lines = cumsum([0 lines sum(lines)]);


