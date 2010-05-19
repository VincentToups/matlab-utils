function simple_pyramidal_cell(active_basilars, active_apicals)
%
%

if ~exist('active_apicals')
  active_apicals = 0;
end
if ~exist('active_basilars')
  active_basilars = 0;
end

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
basilar.conductances.pas.g_pas = .0002;
basilar.conductances.pas.e_pas = -65.0;
if active_basilars
  basilar.conductances.hh = struct;
end


basilars = {};

for i=1:3
  basilar.name = sprintf('basilar%d',i);
  basilars{i} = section(basilar);
  connect(basilars{i},0,soma,0);
end

apical.L = 300;
apical.diam = 1;
apical.nseg = 23;
apical.conductances.pas.g_pas = .0002;
apical.conductances.pas.e_pas = -65.0;
if active_apicals
  apical.conductances.hh = struct;
end

section(apical);

connect(apical,0,soma,1);

axon.L = 1000;
axon.diam = 1;
axon.nseg = 37;
axon.Ra = 100;
axon.cm = 1;
axon.conductances.hh = struct;

section(axon);
connect(axon,0,soma,0);

hoc access soma

