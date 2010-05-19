close all
mstruct = load_morph('morphology_out');
nsyns = 1000000;

dends = submorph_re(mstruct,'a*');
% a non-trivial selection

ns = distribute_syns('disttest.syns',dends, nsyns, 100, 100, 100, ...
                     1212);

inds = [dends(:).ind];
[nothing,ii] = sort(inds);
areas = [dends(:).area];
areas = areas(ii);
plot(areas/max(areas),ns/max(ns),'.');
xl = xlim;
xs = linspace(xl(1),xl(2),500);
hold on
plot(xs,xs,'LineWidth',2,'Color','k');
hold off
xlabel('Normalized Area');
ylabel('Norm. # Synapses');
title('Synapse Distribution Test');
vprint('distribute_synapses_test');

%%%> 
