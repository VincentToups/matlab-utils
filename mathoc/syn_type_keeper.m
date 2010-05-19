function hoc__=syn_type_keeper(params)
% HOC__=SYN_TYPE_KEEPER(PARAMS)

if ~exist('params')
  params = struct;
end

global hoc__
hoc__ = [hoc__ create_syn_type_keeper(params)];

