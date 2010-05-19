function dset = dsautoseg(dset)
% DSAUTOSEG is an automatic segmenter for DATASET objects
%
%   DSET = DSAUTOSEG(DSET) resegments the data represented by dset
%       without supervision.
%
%   This function works almost as well as you would like it to, but
%   I suggest using the pleasant and painless user interface with other
%   manual segmenting options.
%
%   See also DSMANSEG


sp = spmake;
seg.per = dset.per;
seg.pown = 1;
seg.powd = 1/dset.segparam;
sp.bin = dset.segbin;

dset.segtimes = findsegs(dset.dataset, sp);
dset.nseg = length(dset.segtimes)-1;

for i=1:dset.nseg
    dset.segs(i) = dataseg(dset.segtimes(i),dset.segtimes(i+1));
end

dset.private.reseg = 0;

