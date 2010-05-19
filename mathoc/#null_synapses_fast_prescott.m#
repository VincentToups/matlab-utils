function syngroups = null_synapses_fast_prescott(tstop,varargin)

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

syngroups(1) = exc_syn_params_env('name', 'bge', 'nsyn', round(750*10/synscale), 'list_or_name', basilarrefs ,'env_tstop',tstop,'envelope',exc_env);
syngroups(end+1) = exc_syn_params('name', 'ffe', 'nsyn', round(250*10/synscale), 'list_or_name', basilarrefs(1),...
                                  'envelope', inline('0','t'),'env_tstop',tstop);
syngroups(end+1) = exc_syn_params_env('name', 'ap_bge', 'nsyn', round(100*10/synscale), 'list_or_name', tuftsrefs,...
                                      'dist_from_soma',145,'env_tstop',tstop,'envelope', exc_env);

%; (+ 1000 7500 2500)

syngroups(end+1) = inh_syn_params('name', 'ap_bgi_bal', 'nsyn', round(40*10/synscale), 'list_or_name', tuftsrefs,...
                                  'dist_from_soma',145,'env_tstop',tstop,'envelope', inh_env);
syngroups(end+1) = inh_syn_params('name', 'ap_bgi', 'nsyn', round(40*10/synscale), 'list_or_name', tuftsrefs,...
                                  'dist_from_soma',145,'envelope', inh_env,'env_tstop',tstop);
syngroups(end+1) = inh_syn_params('name', 'bgi_bal', 'nsyn', round(40*10/synscale), 'list_or_name', [basilarrefs {'somaref'}], 'dist_from_soma',75,'width',25,'env_tstop',tstop, 'envelope', inh_env);
syngroups(end+1) = inh_syn_params('name', 'bgi', 'nsyn', round(40*10/synscale), 'list_or_name', [basilarrefs {'somaref'}],'envelope',inh_env,'env_tstop',tstop,'dist_from_soma',75,'width',25);

names = { syngroups(:).name };
excii = [find(map(@(x) strcmp(x(end),'e'), names)) ];
inhii = [find(map(@(x) strcmp(x(end),'i'), names)) 3 6];

if ~exist('gexc')
  gexc = 3.8e-4;
end
if ~exist('ginh')
  ginh = 4.03e-4;
end
for ii=excii, syngroups(ii).g = gexc; end
for ii=inhii, syngroups(ii).g = ginh; end



%; (let ((ninh (* 400 4)) (nexc (+ 1000.0 7500 2500))) (/ ninh (+ ninh nexc)))


%; (/ 125 2.5)
