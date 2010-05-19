function spikes = mtfake(m,s,r,tc,nt)
% SPIKES=MTFAKE(M,S,R,TC,NT) returns a surrogate dataset 
% with events at the means stored in M and standard deviations
% and reliabilities given by S, and R.  TC indicates which 
% cluster the event appears in (each event can appear in multiple
% clusters).  NT is the number of clusters desired for each pattern
% specified in TC.  That is length(unique(tc))==length(nt)

if strcmp(class(tc),'double')
    un = unique(tc);
    spikes = [];
    for i=1:length(un)
        ii=find(un(i)==tc);
        if ~isempty(ii)
            ms = m(ii);
            ss = s(ii);
            rr = r(ii);
            sspikes = fake(ms,ss,rr,nt(i));
            spikes = sloppycat(spikes,sspikes,1);
        end
    end
else
    un = unique( [tc{:}] );
    spikes = [];
    for i=1:length(un)
        ii = [];
        for j=1:length(tc)
            if any(tc{j}==un(i))
                ii = [ii j];
            end
        end
        if ~isempty(ii)
            ms = m(ii);
            ss = s(ii);
            rr = r(ii);
            sspikes = fake(ms,ss,rr,nt(i));
            spikes = sloppycat(spikes,sspikes,1);
        end
    end
end
