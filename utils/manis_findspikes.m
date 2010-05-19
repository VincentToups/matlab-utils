function spikes = manis_findspikes(traces, thresh)
% SPIKES=MANIS_FINDSPIKES(TRACES) finds spike times in voltage
% traces by finding places where the voltage crosses a threshold.
% This is a simple routine which should work for fairly clean data,
% as is usually produced by the Manis lab in slice.

[i,j] = find( traces > thresh);

m = full( sparse(i,j, ones([1 length(i)])) );
m1 = diff(m);
[i,j] = find(m1==1);
m2 = full(sparse(i,j,ones([1 length(i)]), size(traces,1), size(traces,2)));
m2 = m2';

t = linspace(0, 1, size(traces,1) );

spikes = [];
for kk = 1:size(traces,2)
    cr = m2(kk, :);
    ii = find(cr);
    tt = t(ii);

    if length(tt) < size(spikes, 2)
        tt(size(spikes,2)) = 0;

    elseif length(tt) > size(spikes,2)
        spikes(1,length(tt)) = 0;
    end

    spikes = [spikes; tt];
end


