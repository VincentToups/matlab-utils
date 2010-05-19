function sp = spmake(per, pown, powd, bin, gui)
% SPMAKE initializes a segmentation parameter (SP) object.
%
% SP = SPMAKE( PER, POWN, POWD, BIN ) returns an SP object with the
% parameters specified.  SP = SPMAKE returns a default version

if nargin == 0
    sp.per = 2;
    sp.pown = 2;
    sp.powd = .2;
    sp.bin  = 2;
    sp.gui  = 0;
else
    sp.per = per;
    sp.pown = pown;
    sp.powd = powd;
    sp.bin = bin;
    sp.gui = gui;
end

