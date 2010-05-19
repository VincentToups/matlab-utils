% test poisson 

close all
prefix = 'poisson_template';

spikes = load([prefix '.spikes']);
template = load([prefix '.template']);


tstop = template(2);
rate = template(1);

spikes = section(spikes,0,tstop);
spikes = spikes(:,:,1);

subplot(2,2,1);
pubrast(spikes);
xlim([0 tstop]);
xlabel('Time (ms)')
ylabel('Trial')
rrate = mean(sum(spikes>0,2)/tstop);
title(sprintf('rate = %f, real rate = %f',rate,rrate));

subplot(2,2,2);
% find counts

nspikes = spikes/tstop;
nbins = 20;
ndt = 1/nbins;
nspikes = nspikes/ndt;
nspikes = ceil(nspikes);
[ii,jj,vv] = find(nspikes);
counts = full(sparse(ii,vv,ones([1 length(vv)])));
m = mean(counts);
s = std(counts);
plot(m,s.*s,'.');
xlabel('Mean');
ylabel('Variance');
title('Fano Ratio');

subplot(2,2,3);
isis = diff(spikes,1,2);
isis = isis(isis>0);
hist(isis,50);
ylabel('Count')
xlabel('ISI (ms)')

subplot(2,2,4)

isis = diff(spikes,1,2);
cvs = [];
for i=1:size(isis,1)
  isisl = isis(i,:);
  isisl = isisl(isisl>0);
  s = std(isisl);
  m = mean(isisl);
  cvs = [cvs s/m];
end

hist(cvs,50);
xlabel('ISI CV')
ylabel('Count')

vprint('poisson_template_test')


%%%> 
