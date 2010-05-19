Matlab Utilities
----------------

Created after many years of graduate school in computational
neuroscience, and covering a wide range of tasks from data analysis,
to figure preparation with a large amount of system-connecting in
between.


I am mostly adding putting this up for the sake of the Mathoc
subfolder, which contains a relatively complete and functional bridge
between matlab and the NEURON simulation environment.  Rather than
explain lugubriously, an example may instead be more illustrative of
how it works and what it does:


	init_hoc;
	tstop = 5;
	hoc_variable(tstop);
	dt = .0125;
	hoc_variable(dt);


	call('load_file', "utilities.hoc");
	call('load_file', "savers.hoc");
	hoc('create soma');
	neurons = {};
	nNeurons = 50;
	inhPerc = .2;

	inhibitoryFlag = (1:nNeurons)<(nNeurons.*inhPerc);

	for i=1:nNeurons
	  neurons{i} = instantiate('IntFire4',.5)
	end

	connections = {};
	for i=1:length(neurons)
	  for j=1:length(neurons)
		if i~=j
		  if inhibitoryFlag(i)
			w = -.03;
		  else
			w = .01;
		  end
		  connections{i,j} = instantiate('NetCon',neurons{i},neurons{j},0,0,w);
		end
	  end
	end

	for i=1:nNeurons
	  stim = instantiate('NetStim');
	  hoc_set(stim,'interval',1);
	  hoc_set(stim,'number',1000);
	  hoc_set(stim,'noise',1);

	  netcon = instantiate('NetCon',stim,neurons{i},1,0,5);

	end

	for i=1:nNeurons
	  recording1 = instantiate('VoltageTraceSaver',...
							  'a',...
							  -1,...
							  -1,...
							  code('utils.nil'),...
							  sprintf('/tmp/recording%d.data',i),neurons{i},'m');
	end

	simulation_loop(1);

	for i=1:nNeurons
	  delete(sprintf('/tmp/recording%d.data',i));
	end

	do_hoc(1);
	data = [];
	for i=1:nNeurons
	  data = [data; load(sprintf('/tmp/recording%d.data',i))];
	end
	t = linspace(0,tstop,length(data));
	close all
	plot(t,data);


The above piece of code uses NEURON, via Matlab or Octave, to create a
dead stupid model of a micro-column-like neural network.  Fifty
neurons are created, and around 20% are assigned inhibitory status.
Then synaptic connections are created between all neurons depending on
that status.  Finally, excitatory input is created via a series of
NetStim objects connected to each neuron, and objects for recording
the voltages of the neurons are created.  `do_hoc` initiates the
simulation, and then the data from it is loaded and plotted.

Documentation is sparse right now, but the above example shows you how
to do most everything you'd want to do.  The system needs to know
where your Neuron executable (nrniv) is located.  You tell it by
specifying the global variable `hoc_exe_name__`.

This whole system is based on Matlab compiling a hoc file describing
the simulation, and then running it when `do_hoc` is called.  You can
check the file by looking at the global variable `hoc__`.

There is a lot of stuff going on behind the scenes with file names and
so forth, and a lot of utilities on the hoc side to make things
easier.  I'll talk about them as I document them.

Finally, you can't use this package without having my whole matlab
repository on the path somewhere (including sub-directories).  

