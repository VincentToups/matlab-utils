function layer_23_pc(stru,varargin)
%
%

soma.L = 30;
soma.diam = 30;
soma.nseg = 10;
soma.Ra = 100;
soma.cm = 1;
soma.conductances.hh = struct;

section(soma);

basilar.L = 100;
basilar.diam = 2;
basilar.nseg = 10;
basilar.Ra = 100;
basilar.cm = 1;
basilar.conductances.pas.g_pas = 1e-3;
basilar.conductances.pas.e_pas = -65.0;

nbasilars = 4;
basilars = {};

for i=1:nbasilars
  basilar.name = sprintf('basilar%d',i);
  basilars{i} = section(basilar);
  connect(basilars{i},0,soma,0);
end


apical_trunk.L = 100;
apical_trunk.diam = 1;
apical_trunk.nseg = 23;
apical_trunk.conductances.pas.g_pas = 1e-3;
apical_trunk.conductances.pas.e_pas = -65.0;

section(apical_trunk);

connect(apical_trunk,0,soma,1);

napical_tufts = 2;
tuft.L = 85;
tuft.diam = 1;
tuft.nseg = 32;
tuft.conductances.pas.g_pas = 1e-3;
tuft.conductances.pas.e_pas = -65.0;

for i=1:napical_tufts
  tuft.name = sprintf('tuft%d', i);
  section(tuft);
  connect(tuft,0,apical_trunk,1);
end

axon.L = 1000;
axon.diam = 1;
axon.nseg = 37;
axon.Ra = 100;
axon.cm = 1;
axon.conductances.hh = struct;

section(axon);
connect(axon,0,soma,0);

hoc access soma;


