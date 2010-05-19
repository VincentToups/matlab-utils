function make_spike_file_via_pattern(pat_spec, filename)
%
%
%

%e% filename = 'testacular'
%e% pat_spec.indexes = 1:300;
%e% pat_spec.pattern = sort(repmat(1:2,[1 150]));
%e% pat_spec.m = [100 200 500]
%e% pat_spec.r = [.9 .9  .9];
%e% pat_spec.s = [10  10  10];
%e% pat_spec.l = {[1] [2] [1]};

%% NT is specified by the indexes and patterns

[ptn,ii] = sort(relabel(pat_spec.pattern));
ind = pat_spec.indexes(ii); % Make sure that the indexes are preserved

un = unique(ptn);
nt = repmat(0,length(un))
for i=1:length(un)
  nt(i) = length(find(ptn==un(i)))
end

spikes = mtfake(pat_spec.m,pat_spec.s,pat_spec.r,pat_spec.l,nt);

save_spike_file(filename,spikes,ind);

%%%> 