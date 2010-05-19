function [voltage_traces_file,spikes_file]=setup_balanced_exc(phase,edepth,idepth,delay,ereli,estd,seed,rebuild,tstop)

if ~exist('ereli')
  ereli = .75;
end
if ~exist('estd')
  estd = 8;
end

if ~exist('rebuild')
  rebuild = 1;
end

if ~exist('edepth')
  edepth = .1;
end
if ~exist('idepth')
  idepth = .5;
end

if ~exist('delay')
  delay = 2;
end

if ~exist('seed')
  seed = 10101;
end

if ~exist('tstop')
  tstop = 600;
end

voltage_traces_file = sprintf('data/osctraces_%f_%f_%f_%f_%f_%f.trace',phase,delay,ereli,estd,edepth,idepth);
spikes_file = sprintf('data/oscspikes_%f_%f_%f_%f_%f_%f.spikes',phase,delay,ereli,estd,edepth,idepth);

if rebuild

  init_hoc
  layer_23_pc;
  simulation_libraries
  hoc_variable(tstop);
  basilarrefs = map(@(x) [x 'ref'], sections_re('basilar.*'));
  tuftsrefs = map(@(x) [x 'ref'], sections_re('tuft.*'));
  exc_env = @(t) 1/1000 + (edepth/1000)*sin(2*pi*(10/1000)*t+phase);
  inh_env = @(t) 5/1000 + (idepth/1000)*sin(2*pi*(10/1000)*(t-delay)+phase);
  exc_syn_params_env = @(varargin) exc_syn_params('envelope',exc_env,'g',.8e-3,varargin{:});

  clear syngroups
  %try
  syngroups(1) = exc_syn_params_env('name', 'bge', 'nsyn', 750, 'list_or_name', basilarrefs ,'env_tstop',tstop);
  syngroups(end+1) = exc_syn_params('name', 'ffe', 'nsyn', 250, 'list_or_name', basilarrefs(1),...
                                'envelope', @(t) 0,'env_tstop',tstop);
  syngroups(end+1) = inh_syn_params('name', 'bgi', 'nsyn', 125, 'list_or_name', basilarrefs ,'env_tstop',tstop);
  syngroups(end+1) = inh_syn_params('name', 'bgi', 'nsyn', 125, 'list_or_name', basilarrefs,'envelope',inh_env,'env_tstop',tstop);
  syngroups(end+1) = exc_syn_params_env('name', 'ap_bge', 'nsyn', 1000, 'list_or_name', tuftsrefs,...
                                    'dist_from_soma',145,'env_tstop',tstop);
  syngroups(end+1) = inh_syn_params('name', 'ap_bgi', 'nsyn', 125, 'list_or_name', tuftsrefs,...
                                'dist_from_soma',145,'env_tstop',tstop);
  syngroups(end+1) = inh_syn_params('name', 'ap_bgi', 'nsyn', 125, 'list_or_name', tuftsrefs,...
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
  simulation_loop(1);
  
end


