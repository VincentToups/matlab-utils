function [events,fid] = extract_events_isi(spikes,thresh,filtn,dt)
%
%
%

s=spikes(:,:,1);
times=sort(s(s>0));
isi = diff(times);

if ~exist('filtn')
    filtn = round(size(spikes,1)*.05); 
    if not(mod(filtn,2)) 
      filtn = filtn -1; 
    end
    if filtn<=0
      filtn =1;
    end
end

%filtn = 1;

if ~exist('dt')
  dt = 1;
end

fid = filter(ones([1 filtn])/filtn,1,isi);
fid = fid(:)';
size(fid);
mx = max(fid);
thresh = thresh*mx;
%e% filt_isi_dist = fs;
%e% filtn = filtern;
%e% times = s;
%e% thresh = 10;

%close all

%subplot(2,1,1); plot(fid);

shift = - (filtn+1)/2;
igt = fid>thresh;
ilt = fid<=thresh;
%hold on; plot(igt*80,'g'); plot(ilt*80,'r'); hold off;
ilt = [ilt(2:end) 0];

%hold on; plot( (ilt & igt)*20 + 85, 'k'); hold off

iibu = find(ilt & igt); % bottom up


igt = fid>thresh;
ilt = fid<=thresh;

igt = [igt(2:end) 0];
iiud = find(ilt & igt);

tbu = times(iibu);
tud = times(iiud);



%ii = sort(repmat(ii(:)',[1 2]));
%ii = [1 ii+shift length(times)];
%tt = times(ii);
%ii = reshape(ii,[2 length(ii)/2])';
%tt = reshape(tt,[2 length(tt)/2])';

if length(tbu) > length(tud)
  %tbu = tbu(1:end-1);
  tud = [tud; times(end)];
end
if length(tud) > length(tbu)
  %tud = tud(2:end);
  tbu = [times(1); tbu];
end

tud
tbu
tt = [tbu(:) tud(:)];
tt

nt = size(spikes,1);
leftovers = spikes;
for bi=1:size(tt,1)
  bracket = sort(tt(bi,:));
  ss = section(spikes,bracket);
  ss = ss(ss>0);
  events(bi).bracket = bracket;
  events(bi).m = mean(ss);
  events(bi).r = length(ss)/nt;
  events(bi).s = std(ss);
end



%e%ts = ii(:,1);
%e%close all
%e%rast(spikes);
%e%for t=ts
%e%  line([times(t) times(t)],ylim);
%e%end


