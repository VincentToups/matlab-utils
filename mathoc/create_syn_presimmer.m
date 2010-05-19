function str=create_syn_presimmer(seed,name)
%
%

if ~exist('seed')
  seed = 10101;
end

if ~exist('name')
  name = new_unique_obj_name();
end

str = [newline sprintf('objref %s', name)];
str = [str newline sprintf('%s = new SynResetPreSim(%d)', name, seed) newline];

