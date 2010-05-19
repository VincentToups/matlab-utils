function [spikes,bwr] = better_fake(ms,rs,ss,oc,ns)
%
%
%

spikes = repmat(0,[sum(ns) length(ms)]);
inds = {};
root = 0;
for i=1:length(ns)
  ind = root + (1:ns(i));
  inds{i} = ind;
  root = ind(end);
end
for i=1:length(ms)
  cinds = [];
  cs = oc{i};
  for j=1:length(cs)
    cinds = [cinds inds{cs(j)}];
  end
  cinds(rand([1 length(cinds)])>rs(i)) = []; % Remove missing spikes
  spikes(cinds,i) = randn([1 length(cinds)])*ss(i) + ms(i);
end

bwr = +(spikes~=0);
for i=1:size(spikes,1)
  ss = spikes(i,:);
  ss = ss(ss>0);
  spikes(i,:) = 0;
  spikes(i,1:length(ss)) = ss;
end

%{
% Test

ms = [10 50 100];
rs = [.9 .9 .9];
ss = [5  2   10];
oc = {[1 3] [1 2] [1 3]};
ns = [50 50 25];
[spikes,bwr] = better_fake(ms,rs,ss,oc,ns);
close all
figure
subplot(2,1,1); rast(spikes);
subplot(2,1,2); imagesc(bwr);

%}
