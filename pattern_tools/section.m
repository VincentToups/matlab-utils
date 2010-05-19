function subset=section_spikes(set, t1, t2)
% SECTION returns spike times from a subset of time
%
% SUBSET=SECTION(SET, T1, T2) returns a SUBSET of the data in SET
% between the times T1 and T2, with spurious zeros removed.  T1<T2.
% Can also be called SECTION(SET,[T2 T2])

if ~exist('t2')
  t2 = t1(2);
  t1 = t1(1);
end

subset = set;

subset(subset<t1) = 0;
subset(subset>t2) = 0;

subset = trimzeros(subset);
if length(size(set)) == 2
  subset = subset(:,:,1);
end
return;

%%% Copyright Static     %%%
% Jonathan Toups, University of North Carolina at Chapel Hill
% Department of Physics, Copyright 2003-2004
% email: toups@physics.unc.edu
%%% End Copyright Static %%%



