%function isi_thresher(spikes,thresh,filtern)

%e% close all
%e% ppp = pwd;
%e% cd ~/afshome/work/reli_paper/
%e% x = load('data/fellous/rat/mat_files/attrpaul/r_sethand_090203Attrpaul1res2b.mat'); 
%e% cd(ppp)
%e% spikes = x.sethand.dst.dataset;
%e% spikes = section(spikes(36:end,:,1),[800 2000]);
%e% rast(spikes) 
%e% thresh = .01
%e% threshstep = 1;
%e% filtern = size(spikes,1)*.05;
%e% 

events = extract_events_isi(spikes,10);

filtern = round(filtern);
if mod(filtern,2)
  filtern = filtern+1;
end

s = sort(spikes(spikes>0));
ds = diff(s);
help filter
a = repmat(0,[1 round(filtern)]);
a(1) = 1;
fs = filter(ones([1 filtern])/filtern,1,ds);
subplot(2,1,1);
plot(fs)
xlabel('index')
ylabel('filtered isi')
ns = [];
counts = [];
np = -173.2;
done = 0;
threshes = [];
first_thresh = thresh;
centers = [];
while not(done)
  ii = find(fs>thresh);
  dd = [2 diff(ii)' 2];
  n = length(dd);
  if isempty(ns) || n == ns(end)
    np = np + 1;
  else
    counts = [counts np];
    centers = [centers mean([thresh first_thresh])];
    np = 1;
    first_thresh = thresh;
  end
  ns = [ns n];
  threshes = [threshes thresh];
  thresh = thresh + threshstep;
  if n-1 == 1
    done = 1;
  end
end
subplot(2,1,2);
plot(threshes, ns);
xlabel('threshold')
ylabel('n events')

%find largest plateau
[v,i] = max(counts);
thresh = centers(i);
xl = xlim();
yl = ylim();
line([thresh thresh],yl);

subplot(2,1,1);
xl = xlim();
line(xl,[thresh thresh]);





