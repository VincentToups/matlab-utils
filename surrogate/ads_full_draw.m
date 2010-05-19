function [spikes,words,eventform]=ads_full_draw(ads,n)
% [SPIKES, WORDS, EVENTFORM] = ADS_FULL_DRAW(ADS,N)
%  produces an entire data set with properties of ADS
%  and N trials.

[words, numw, nper] = ads_draw(ads,n);
spikes = words;
eventform = words;
ii = (spikes==0);
for i=1:size(spikes,2)
  col = spikes(:,i);
  col(col~=0) = ads.events(i).m + ...
    ads.events(i).s*randn(size(col(col~=0)));
  spikes(:,i) = col;
  col = eventform(:,i);
  col(col~=0) = i;
  eventform(:,i) = col;
end

for i=1:size(spikes,1)
  row = spikes(i,:);
  spikes(i,:) = 0;
  [ss,ii] = sort(row(row~=0));
  row(1:length(ss)) = ss;
  spikes(i,1:length(ss)) = ss;
  
  row = eventform(i,:);
  eventform(i,:)=0;
  row = row(row~=0);
  eventform(i,1:length(row)) = row(ii);
end

spikes = trimzeros(spikes);
eventform = trimzeros(eventform);
