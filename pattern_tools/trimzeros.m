function s=trimzeros(sets)
% TRIMZEROES removes trailing and preceding zeros from a dataset.
%
% S=TRIMZEROS(SETS) returns the spike train data set with all extraneous
% padding zeros removed.
%
% See also SECTION

sz = size(sets);
sets = sets(:,:,1);
osets = [];
for i=1:sz(1)
  tt = sets(i,:);
  tt = sort(tt(tt>0));
  if isempty(tt)
    tt = 0;
  end
  osets = sloppycat(osets,tt,1);
end
s = osets;






%%% Copyright Static     %%%
% Jonathan Toups, University of North Carolina at Chapel Hill
% Department of Physics, Copyright 2003-2004
% email: toups@physics.unc.edu
%%% End Copyright Static %%%



