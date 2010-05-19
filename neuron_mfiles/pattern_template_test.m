%% verification figure for PP
close all

prefix = 'ff_exc_1';
spikes = load([prefix '.spikes']);
template = load([prefix '.template']);

subplot(2,1,1);
pubrast(spikes);

for i=1:size(template,2)
  c = template(1,i)
  h = size(spikes,1)*template(2,i)
  w = template(3,i)
  
  rectangle('position',[c-w/2 0 w h])
end

xlabel('Time');
ylabel('Trial');
title('Boxes are events');
vprint(['pattern_template_fig_' prefix]);

%%%> %% verification figure for PP
%%%> >> close all
%%%> 
%%%> 