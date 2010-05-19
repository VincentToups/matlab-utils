function segs = findsegs(spikes, sp, spike_rate, times)
% FINDSEGS attempts to optimize the placement of segment boundaries.
%
% SEGS=FINDSEGS(SPIKES, SP) returns a set of
% segmentations found by placing delimiters at troughs in the spike rate
% which minimize the score given by (SP.PER - avgnum)^SP.POWN 
% + rate_at_cut^SP.POWD.  A default SP can be made with SPMAKE.
% Returns SEGS as an array of numeric arrays of the cut times.  BIN is
% the bin size used to estimate the spike rate.

per = sp.per;
pown= sp.pown;
powd= sp.powd;
bin = sp.bin;

[nt ns] = size(spikes);

if ~exist('spike_rate')
    %This is the first call, not one of the recursions
    [spike_rate times] = rate(spikes, bin);
    spike_rate = spike_rate/nt;
	
	numspikes = cumsum( spike_rate );
	
	first_cut = min( spikes(spikes>0) );
	
	fit = abs(per - numspikes).^pown + (spike_rate).^powd;
%     plot(linspace(0, 1, length(fit)), fit)
	[v i] = min( fit );
	seg = [ 0 times(i)];
    ii = find(times>times(i));
    segs = [seg findsegs( section(spikes, times(i), max(spikes(spikes>0))), sp, spike_rate(ii), times(ii) )];
    mx = ceil( max(spikes(spikes>0)) );
    mx = mx(1)
    segs = [segs mx];
elseif length( spikes(spikes>0) ) > per*nt & ~isempty( times )
    %this is a recursive call
    [nt ns] = size(spikes);
	
	numspikes = cumsum( spike_rate );
	
	first_cut = min( spikes(spikes>0) );
	
	fit = (per - numspikes).^pown + (spike_rate).^powd;
	[v i] = min( fit );
	seg = times(i);
    ii = find(times>times(i));
    segs = [seg findsegs( section(spikes, times(i), max(spikes(spikes>0))), sp, spike_rate(ii), times(ii) )];
else
    mx = ceil( spikes(spikes>0) );
    mx = mx(1);
    segs = [];
end






%%% Copyright Static     %%%
% Jonathan Toups, University of North Carolina at Chapel Hill
% Department of Physics, Copyright 2003-2004
% email: toups@physics.unc.edu
%%% End Copyright Static %%%



