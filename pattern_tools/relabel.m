function cc=relabel(cc)
% RELABEL removes empty clusters.
%
% CC=RELABLE(CC) is a function which relabels the clustering in CC
%  so that UNIQUE(CC) == 1:LENGTH(CC) 

un = unique(cc);
for uni=1:length(un)
    cc(cc==un(uni)) = uni;
end

