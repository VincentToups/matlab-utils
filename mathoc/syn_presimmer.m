function hoc__=syn_presimmer(seed, name)
%
%

if ~exist('seed')
  seed = 10101;
end

if ~exist('name')
  name = new_unique_obj_name();
end

global hoc__
hoc__ = [hoc__ newline create_syn_presimmer(seed,name)];

