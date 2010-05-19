function [ind, spikes] = load_spike_file(filename)
%
%
%

%e% filename = 'testacular'

file = fopen(filename);


format_string = '%f';
result = fscanf(file,format_string);

nsyn = result(1);
done = 0
i = 2
trial = 1;
spikes = zeros([nsyn 20]);
ind = zeros([nsyn 1]);
while not(done)
  ind(trial) = result(i);
  i = i + 1;
  n = result(i);
  i = i + 1;
  for j=1:n
    spikes(trial,j) = result(i);
    i = i + 1;
  end
  
  trial = trial + 1;
  if i > nsyn 
    done = 1;
  end
end
%spikes = trimzeros(spikes);
ind = ind + 1;
rast(spikes);

%%%> 