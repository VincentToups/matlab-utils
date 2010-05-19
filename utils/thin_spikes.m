function spk=thin_spikes(spikes,p)
%
%
[i,j,v] = find(spikes);
v = v.*[rand(size(v))<p];
spk = section_spikes(full(sparse(i,j,v)), [ix(min(v),1)-1 ix(max(v),1)+1]);


