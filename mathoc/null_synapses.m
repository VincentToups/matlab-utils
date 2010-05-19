function syngroups = null_synapses(tstop)

init_hoc;
layer_23_pc;
simulation_libraries;

basilarrefs = map(@(x) [x 'ref'], sections_re('basilar.*'));
tuftsrefs = map(@(x) [x 'ref'], sections_re('tuft.*'));
exc_env = inline('1/1000','t');
inh_env = inline('5/1000','t');
exc_syn_params_env = @(varargin) exc_syn_params('envelope',exc_env,'g',.8e-3,varargin{:});

syngroups(1) = exc_syn_params_env('name', 'bge', 'nsyn', 750, 'list_or_name', basilarrefs ,'env_tstop',tstop);
syngroups(end+1) = exc_syn_params('name', 'ffe', 'nsyn', 250, 'list_or_name', basilarrefs(1),...
                                  'envelope', inline('0','t'),'env_tstop',tstop);
syngroups(end+1) = inh_syn_params('name', 'bgi_bal', 'nsyn', 125, 'list_or_name', [basilarrefs {'somaref'}]  ,'env_tstop',tstop);
syngroups(end+1) = inh_syn_params('name', 'bgi', 'nsyn', 125, 'list_or_name', [basilarrefs {'somaref'}],'envelope',inh_env,'env_tstop',tstop);
syngroups(end+1) = exc_syn_params_env('name', 'ap_bge', 'nsyn', 1000, 'list_or_name', tuftsrefs,...
                                      'dist_from_soma',145,'env_tstop',tstop);
syngroups(end+1) = inh_syn_params('name', 'ap_bgi_bal', 'nsyn', 125, 'list_or_name', tuftsrefs,...
                                  'dist_from_soma',145,'env_tstop',tstop);
syngroups(end+1) = inh_syn_params('name', 'ap_bgi', 'nsyn', 125, 'list_or_name', tuftsrefs,...
                                  'dist_from_soma',145,'envelope', inh_env,'env_tstop',tstop);

