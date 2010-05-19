init_hoc;
layer_23_pc;
simulation_libraries;
hoc_variable(tstop);

for i = 1:length(syngroups)
  envsyngroup(syngroups(i));
  hoc(sprintf('print "Done syn group %d"',i));
end

vtnames = {};
for i=1:length(voltage_recorders)
  [non,non,vtnames{i}] = voltage_trace_saver(voltage_recorders(i));
  hoc(sprintf('print "Done setting up voltage trace saver %d"',i));
end

spnames = {};
for i=1:length(spike_recorders)
  [non,non,spnames{i}] = spike_train_saver(spike_recorders(i));
  hoc(sprintf('print "Done setting up spike trace saver %d"',i));
end
%

syn_presimmer(seed);
hoc('print "Set up presimmer"');
simulation_loop(nrepeat,'print "sim ", i', 'print "done sim ", i');
tic;
do_hoc;
elapsed = toc;

voltages = struct;
for vi=1:length(vtnames)
  vtname=vtnames{vi};
  if strip_timestamps
    vtnametarget = regexprep(vtname, '-\d{4,4}-\d{1,2}-\d{1,2}-\d{1,2}-\d{1,2}-\d{1,2}_\d{4,4}', '')
  else
    vtnametarget = vtname;
  end
  sname = foldl( @(it, ac) strrep(ac,it,''), vtnametarget, { '.trace', '+', '-', '*', '/' });
  voltages.(sname) = load(vtname);
  
end

spikes = struct;
for si=1:length(spnames)
  spname=spnames{si};
  spname=spnames{vi};
  if strip_timestamps
    spnametarget = regexprep(spname, '-\d{4,4}-\d{1,2}-\d{1,2}-\d{1,2}-\d{1,2}-\d{1,2}_\d{4,4}', '')
  else
    spnametarget = spname;
  end
  sname = foldl( @(it, ac) strrep(ac,it,''), spnametarget, { '.spikes', '+', '-', '*', '/' });
  spikes.(sname) = load_uneven_spikes(spname);
end

