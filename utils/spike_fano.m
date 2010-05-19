function f = spike_fano(sp)
%
%

counts = sum( sp> 0, 2);
f = var(counts)/mean(counts);
