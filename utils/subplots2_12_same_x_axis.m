function [a1 a2]=subplots2_12_same_x_axis()

% close all
clf
p1 = [0.1300+.0939    0.5838    0.5521    0.3412];
p2 = [0.1300+.0939    0.1862    0.5521    0.3412];

a1 = axes('position',p1,'XTickLabelMode','manual');
a2 = axes('position',p2);

set([a1 a2],'LineWidth',2,'FontSize',18,'Fontname','Helvetica');
