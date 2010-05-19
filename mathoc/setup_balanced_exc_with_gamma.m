function [voltage_traces_file, spikes_file] = setup_balanced_exc_with_gamma(varargin)

phase = 0;
ereli = .75;
estd = 8;
rebuild = 1;
edepth = .1;
idepth = 1.5*.1;
gammadepth = .5;
delay = 2;
seed = 10101;
tstop = 600;
nrepeat = 1;

s = varargs_to_struct(varargin);
unpack s;

fprintf('tstop %f\n',tstop);

voltage_traces_file = sprintf('data/osctraces_%f_%f_%f_%f_%f_%f_%f.trace',gammadepth,phase,delay,ereli,estd,edepth,idepth);
spikes_file = sprintf('data/oscspikes_%f_%f_%f_%f_%f_%f_%f.spikes',gammadepth,phase,delay,ereli,estd,edepth,idepth);

if rebuild

  init_hoc
  layer_23_pc;
  simulation_libraries
  tstop = 600;
  hoc_variable(tstop);
  basilarrefs = map(@(x) [x 'ref'], sections_re('basilar.*'));
  tuftsrefs = map(@(x) [x 'ref'], sections_re('tuft.*'));
  if ~exist('exc_env')
    exc_env = @(t) 1/1000 + (edepth/1000)*sin(2*pi*(10/1000)*t+phase);
  end
  if ~exist('gamma')
    gamma = @(t) 5/1000 + (gammadepth/1000)*sin(2*pi*(56/1000)*t);
  end
  if ~exist('inh_env')
    inh_env = @(t) 5/1000 + (idepth/1000)*sin(2*pi*(10/1000)*(t-delay)+phase) + gamma(t);
  end
  
  disp('Gamma is');
  gamma


  exc_syn_params_env = @(varargin) exc_syn_params('envelope',exc_env,'g',.8e-3,varargin{:});

  clear syngroups
  %try
  syngroups(1) = exc_syn_params_env('name', 'bge','save_spikes_name', '/tmp/bge_gamma', 'nsyn', 750, 'list_or_name', basilarrefs ,'env_tstop',tstop);
  syngroups(1+end) = exc_syn_params('name', 'ffe','save_spikes_name', '/tmp/ffe_gamma', 'nsyn', 250, 'list_or_name', basilarrefs(1),...
                                    'envelope', @(t) 0,'env_tstop',tstop);
  syngroups(1+end) = inh_syn_params('g',5e-2,'name', 'bgi_bal','save_spikes_name', '/tmp/bgi_bal_gamma', 'nsyn', 125, 'list_or_name', [basilarrefs {'somaref'}] ,'env_tstop',tstop, 'envelope',inh_env);
  syngroups(1+end) = inh_syn_params('name', 'bgi_gam','save_spikes_name', sprintf('/tmp/bgi_gam_gamma%d',gammadepth), 'nsyn', 125, 'list_or_name', [basilarrefs {'somaref'}],'envelope',gamma,'env_tstop',tstop);
  syngroups(end+1) = exc_syn_params_env('name', 'ap_bge','save_spikes_name', '/tmp/ap_bge_gamma', 'nsyn', 1000, 'list_or_name', tuftsrefs,...
                                        'dist_from_soma',145,'env_tstop',tstop);
  syngroups(end+1) = inh_syn_params('g',5e-2,'name', 'ap_bgi_bal','save_spikes_name', sprintf('/tmp/ap_bgi_bal_gamma%d',gammadepth), 'nsyn', 125, 'list_or_name', tuftsrefs,...
                                    'dist_from_soma',145,'env_tstop',tstop, 'envelope', gamma);
  syngroups(end+1) = inh_syn_params('name', 'ap_bgi_gam','save_spikes_name', '/tmp/ap_bgi_gam_gamma', 'nsyn', 125, 'list_or_name', tuftsrefs,...
                                    'dist_from_soma',145,'envelope', inh_env,'env_tstop',tstop);
  
  for i = 1:length(syngroups)
    envsyngroup(syngroups(i));
    hoc(sprintf('print "Done syn group %d"',i))
  end
  %catch
  %  keyboard
  %end

  vtsaver.filename = voltage_traces_file;
  voltage_trace_saver(vtsaver);

  ssaver.filename = spikes_file;
  spike_train_saver(ssaver);

  syn_presimmer(seed);
  hoc('print "tstop ", tstop');
  hoc('print "dt", dt');
  simulation_loop(nrepeat);
end
