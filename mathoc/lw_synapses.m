function inst=lw_synapses(synfile,generator)
%
%

if nargin==0
  inst = instantiate('LwSynapses');
elseif nargin == 1
  inst = instantiate('LwSynapses',synfile);
elseif nargin == 2
  inst = instantiate('LwSynapses',synfile,generator);
end
