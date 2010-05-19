function syngroups = null_synapses_fast(tstop,varargin)

synscale = 1;
s = varargs_to_struct(varargin);
unpack s

init_hoc;
layer_23_pc;
simulation_libraries;

basilarrefs = map(@(x) [x 'ref'], sections_re('basilar.*'));
tuftsrefs = map(@(x) [x 'ref'], sections_re('tuft.*'));
exc_env = inline(sprintf('1*(%f)/1000',synscale),'t');
inh_env = inline(sprintf('5*(%f)/1000',synscale),'t');
exc_syn_params_env = @(varargin) exc_syn_params('envelope',exc_env,'g',.8e-3,varargin{:});

syngroups(1) = exc_syn_params_env('name', 'bge', 'nsyn', round(750/synscale), 'list_or_name', basilarrefs ,'env_tstop',tstop);
syngroups(end+1) = exc_syn_params('name', 'ffe', 'nsyn', round(250/synscale), 'list_or_name', basilarrefs(1),...
                                  'envelope', inline('0','t'),'env_tstop',tstop);
syngroups(end+1) = inh_syn_params('name', 'bgi_bal', 'nsyn', round(125/synscale), 'list_or_name', [basilarrefs {'somaref'}]  ,'env_tstop',tstop);
syngroups(end+1) = inh_syn_params('name', 'bgi', 'nsyn', round(125/synscale), 'list_or_name', [basilarrefs {'somaref'}],'envelope',inh_env,'env_tstop',tstop);
syngroups(end+1) = exc_syn_params_env('name', 'ap_bge', 'nsyn', round(1000/synscale), 'list_or_name', tuftsrefs,...
                                      'dist_from_soma',round(145/synscale),'env_tstop',tstop);
syngroups(end+1) = inh_syn_params('name', 'ap_bgi_bal', 'nsyn', round(125/synscale), 'list_or_name', tuftsrefs,...
                                  'dist_from_soma',round(145/synscale),'env_tstop',tstop);
syngroups(end+1) = inh_syn_params('name', 'ap_bgi', 'nsyn', round(125/synscale), 'list_or_name', tuftsrefs,...
                                  'dist_from_soma',round(145/synscale),'envelope', inh_env,'env_tstop',tstop);

