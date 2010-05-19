% MS = VPMETRIC_C(SPIKES, QS, KS, LENS, NSUB, PSUB) is the c vpmetric version 2.
% This function should normally be called by the Matlab function VPMETRIC.
% MS is the returned metric space, QS, KS are the q and k values respectively as
% column arrays, LENS is a column array of the lengths of the spike trains in 
% SPIKES, NSUB is the number of spikes in each train and PSUB is the product of 
% the lengths + 1 of all the subtrains of each train and is used to determine 
% which train is the correct pivot train.
%
% If all this seems confusing, use VPMETRIC...
% J Vincent Toups (toups@physics.unc.edu)

