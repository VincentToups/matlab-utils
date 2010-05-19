function [voltage_traces_file,spikes_file]=setup_phase_sim(phase,ereli,estd,rebuild)

if ~exist('ereli')
  ereli = .75;
end
if ~exist('estd')
  estd = 8;
end

if ~exist('rebuild')
  rebuild = 1;
end


voltage_traces_file = sprintf('data/osctraces_%f_%f_%f.trace',phase,ereli,estd);
spikes_file = sprintf('data/oscspikes_%f_%f_%f.spikes',phase,ereli,estd);

if rebuild

  init_hoc
  layer_23_pc;
  simulation_libraries
  tstop = 600;
  hoc_variable(tstop);
  basilarrefs = map(@(x) [x 'ref'], sections_re('basilar.*'));
  tuftsrefs = map(@(x) [x 'ref'], sections_re('tuft.*'));
  exc_env = @(t) 1/1000 + (.1/1000)*sin(2*pi*(10/1000)*t+phase);
  exc_syn_params_env = @(varargin) exc_syn_params('envelope',exc_env,varargin{:});

  syngroups(1) = exc_syn_params_env('name', 'bge', 'nsyn', 1500, 'list_or_name', basilarrefs );
  syngroups(2) = exc_syn_params('name', 'ffe', 'nsyn', 500, 'list_or_name', basilarrefs(1),...
                                'envelope', @(t) (1/3)*sqrt(pi)/2*exp( -(t-300)^2/3^2))
  syngroups(3) = inh_syn_params('name', 'bgi', 'nsyn', 500, 'list_or_name', basilarrefs );
  syngroups(4) = exc_syn_params_env('name', 'ap_bge', 'nsyn', 2000, 'list_or_name', tuftsrefs,...
                                    'dist_from_soma',145);
  syngroups(5) = inh_syn_params('name', 'ap_bgi', 'nsyn', 500, 'list_or_name', tuftsrefs,...
                                'dist_from_soma',145);

  for i = 1:length(syngroups)
    envsyngroup(syngroups(i));
    hoc(sprintf('print "Done syn group %d"',i))
  end

  vtsaver.filename = voltage_traces_file;
  voltage_trace_saver(vtsaver);

  ssaver.filename = spikes_file;
  spike_train_saver(ssaver);

  syn_presimmer
  hoc('print "tstop ", tstop');
  hoc('print "dt", dt');
  simulation_loop(10);
end

