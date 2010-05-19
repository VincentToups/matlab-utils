function vt=remove_vt_transient(traces,how_much,tstop)
% VT=REMOVE_VT_TRANSIENT(TRACES,HOW_MUCH,DT)
%  Removes transient from voltage traces in row=column data at time resolution DT

tt = linspace(0,tstop,size(traces,2));
ii = find(tt>how_much);
vt = traces(:,ii);




