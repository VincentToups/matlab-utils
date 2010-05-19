function [voltages, spikes, elapsed] = setup_null(varargin)

tstop = 1000;
nrepeat = 1;
syngroups = struct;
voltage_recorders = [];
spike_recorders = [];
strip_timestamps = 1;
seed = round(sum(clock));
rebuild = 0;

s = varargs_to_struct(varargin);
unpack s
packstruct params
params.output.voltages = 0;
params.output.spikes = 0;
if isfield(params,'just_hash')
  just_hash = params.just_hash;
  params = rmfield(params,'just_hash');
else
  just_hash = 0;
end
if isfield(params,'keep_elapsed') && params.keep_elapsed == 1
  params.output.elapsed = 0;
  params = rmfield(params,'keep_elapsed');
else
  if isfield(params,'keep_elapsed')
    params = rmfield(params,'keep_elapsed');
  end
end
params = rmfield(params,'varargin');
params.script_name = 'setup_null_body';
if just_hash
  warning('Just hashing');
  params
  if isfield(params,'just_hash')
    params = rmfield(params,'just_hash');
    
  end
  if isfield(params.s,'just_hash')
      params.s = rmfield(params.s,'just_hash');
  end
  str = to_emacs_string(params);
  save('hash_only','str');
  voltages = md5(params);
  voltages
  spikes = [];
  elapsed = [];
  return;
end
output = do_with_parameters(params,rebuild);
unpack output
if ~exist('elapsed')
  elapsed = 0;
end
