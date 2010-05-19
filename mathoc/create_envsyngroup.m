function [str,sgn,enn] = create_envsyngroup(params)
%
%
[str,sng] = create_syn_type_keeper(params);
enparams.name = [sng '_template_rate'];
enn = enparams.name;
if ~isclass('double',params.envelope)
  enparams.envelope = f_to_envelope(params.envelope,params.env_res, params.env_tstop);
else
  enparams.envelope = params.envelope;
end
env_gen_str = create_envelope_template(enparams);
str = [str newline env_gen_str];
str = [str sprintf('\n%s.set_spike_template(%s)\n', sng, enparams.name)];
if isfield(params,'seedpool')
  csv = sprintf('%f, ', params.seedpool);
  csv = csv(1:(end-2))
  str = [str sprintf('%s.set_seed_pool(utils.vector(',enparams.name) csv '))' newline ];
end
