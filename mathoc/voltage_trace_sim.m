function [spikes,traces] = voltage_trace_sim(stru,varargin)
% simple_background launch a NEURON simulation 
%
%
soma_voltage_trace_fn = './data/soma_voltage_trace_fn.trace';
basilar1_voltage_trace_fn = './data/basilar1_voltage_trace_fn.trace';
basilar2_voltage_trace_fn = './data/basilar2_voltage_trace_fn.trace';
basilar3_voltage_trace_fn = './data/basilar3_voltage_trace_fn.trace';
apical_voltage_trace_fn = './data/apical_voltage_trace_fn.trace';
spike_file = './data/top_down_onset_simulation_test.spikes';



if nargin == 0
  stru = struct;
end

if strcmp(class(stru),'char')
  varargin = [{stru} varargin];
  stru = struct;
end

pairs = reshape(varargin,[2 length(varargin)/2]);

for i=1:size(pairs,2)
  eval(sprintf('stru.%s = pairs{2,%d};', pairs{1,i}, i));
end

filenm = [tempname_cleaned() '.hoc']
f = fopen(filenm,'w');

fns = fieldnames(stru);
ischar = @(x) strcmp(class(x),'char');
isnum = @(x) strcmp(class(x),'double');
wait_to_exit = 0;
force_rebuild = 0;
for fni = 1:length(fns)
  fn = fns{fni};
  o = stru.(fn);
  if strcmp(fn,'force_rebuild')
    force_rebuild = o;
  elseif strcmp(fn,'wait_to_exit')
    wait_to_exit = o;
    rep = '';
  elseif strcmp(fn,'do_instead')
    do_instead_filename = [tempname_cleaned() '.hoc'];
    do_instead_file = fopen(do_instead_filename,'w');
    fprintf(do_instead_file,o);
    fclose(do_instead_file);
    rep = string_to_hoc_string(fn,do_instead_filename);
  elseif ischar(o)
    rep = string_to_hoc_string(fn,o);
  elseif isnum(o)
    rep = number_to_hoc_number(fn,o);
  end
  fprintf(f,'%s\n',rep);
end
fclose(f);

if ~wait_to_exit
  eval(sprintf('! ./special -c "strdef parameter_file" -c "parameter_file = \\"%s\\"" ./basic_hocs/top_down_onset_simulation_test.hoc',filenm))
else
  eval(sprintf('! ./special -c "strdef parameter_file" -c "parameter_file = \\"%s\\"" ./basic_hocs/top_down_onset_simulation_test.hoc -',filenm))
end

if nargout > 0
  spikes = load_uneven_spikes(spike_file);
end

if nargout > 1
  traces.soma = load(soma_voltage_trace_fn);
  traces.basilar1 = load(basilar1_voltage_trace_fn);
  traces.basilar2 = load(basilar2_voltage_trace_fn);
  traces.basilar3 = load(basilar3_voltage_trace_fn);
  traces.apical = load(apical_voltage_trace_fn);
end
