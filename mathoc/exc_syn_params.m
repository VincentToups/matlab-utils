function params = exc_syn_params(varargin)
% PARAMS = EXC_SYN_PARAMS( ) returns parameters for excitatory synapses

args = reshape(varargin,[2 length(varargin)/2]);
for ai=1:size(args,2)
  eval(sprintf('%s = args{2,ai};',args{1,ai}));
end

if ~exist('e')
  e = 0;
end
if ~exist('g')
  g = 1.5e-4;
end
if ~exist('tau')
  tau = 3;
end
if ~exist('list_or_name')
  list_or_name = {'basilar1ref' 'basilar2ref' 'basilar3ref'};
end
if ~exist('dist_from_soma')
  dist_from_soma = 90;
end
if ~exist('width')
  width = 35;
end
if ~exist('envelope')
  envelope = inline('1/1000','t');
end
if ~exist('env_res')
  env_res = .1;
end
if ~exist('env_tstop')
  env_tstop = 1000;
end
if ~exist('save_spikes_name')
  save_spikes_name = '';
end


params.e = e;
params.g = g;
params.tau = tau;
params.list_or_name = list_or_name;
params.dist_from_soma = dist_from_soma;
params.width = width;
params.envelope = envelope;
params.env_res = env_res;
params.env_tstop = env_tstop;
params.save_spikes_name = save_spikes_name;

if exist('nsyn') 
  params.nsyn = nsyn;
end

if exist('name' )
  params.name = name;
end
