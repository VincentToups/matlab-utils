function [str,name]=create_syn_group_with_envelope_firing(synparams,envelope)
%
%

if ~exist('envelope') 
  envelope = synparams;
  synparams = struct;
end

[str,name] = create_syn_type_keeper(synparams);
env_params.name = [name '_template'];
env_params.envelope = envelope;
env_gen_str = create_envelope_template(env_params);
str = [str '' env_gen_str];
str = [str sprintf('\n%s.set_spike_template(%s)\n', name, env_params.name)];

