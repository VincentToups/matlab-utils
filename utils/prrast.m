function prrast(spikes,w)

if ~exist('w')
  w = 100;
end

%spk = spikes(spikes>0);
[i,j,spk] = find(spikes);
tlast = max(spk);
time_per_column = tlast/w;
spk = ceil(spk/time_per_column);

spk = full(sparse(i,spk,ones(size(spk))));

for i=1:size(spk,1)
  for j=1:size(spk,2)
    if spk(i,j)
      fprintf('|');
    else
      fprintf(' ');
    end
   end
  fprintf('\n');
end


