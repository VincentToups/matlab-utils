function f=spikefitness(spikes,u,ss,sd,ssz)
% SPIKEFITNESS assigns a fitness for spike clustering.
%
% F=SPIKEFITNESS(SPIKES,U,SS,SD,SSZ) returns the fitnes of a spike clustering
%  given a fitness matrix, the cost for singleton clusters SS, the cost
%  for double occupancy SD and the minimum non-singleton size (not,
%  as the nomenclature would seem to suggest, necessarily one.)
%
% See also DATASEG on how to drop in your own fitness measure.
%

spikes = spikes(:,:,1);

f = sfitness(u);
sz = size(spikes);
ti = repmat([1:sz(1)]',[1 sz(2)]);

spikes = spikes;
si = find(spikes);
st = spikes(si);
ti = ti(si);

[nothing,labels] = max(u);
un = unique(labels);
lun = length(un);
for i=1:lun
    sl = ti(labels==un(i));
    if length(sl) > ssz
        pn = abs(length(unique(sl)) - length(sl));
        f = f - pn*sd;
    else
        f = f - ss;
    end
end

    


