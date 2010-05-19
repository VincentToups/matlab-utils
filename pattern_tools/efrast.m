function efrast(ef)
% EFRAST plots a rastergram of the event form EF.
% EFRAST(EF) plots a rastergram of the eventform
%  produced by the DSEMODEL step in the pattern
%  tools analysis process.  This object can be
%  accesses by ds.segs(i).eventform, and shows
%  the dataset in such a way that each column of
%  a matrix is an event, and each row a trial.
%
%  Where there are spikes, this matrix has a one,
%  and it holds zeros otherwise.

dsconstants;

if ~ishold
    cla;
end

trials = [1:size(ef,1)]';

hold on;
for i=1:size(ef,2)
    times = ef(:,i);
    ii = find(times>0);
    times = times(ii);
    tr = trials(ii);
    plot(times,tr,'d','MarkerFaceColor', CLRS(mod(i,size(CLRS,1))+1,:) );
end

if ~ishold
    hold off;
end
   
