standards
close all
addpath(['~/axon_toups_scratch/toups/data/fellous/rat/mat_files/' ...
         'attrpaul'])
load('r_sethand_090203Attrpaul1res2b.mat'); 
spikes = sethand.dst.dataset;
spikes = section(spikes(36:end,:,1),[800 2000]);

threshes = logspace(log(.05),log(.95),size(spikes,1));
subplot(2,2,1);
pubrast(spikes);
ylabel('Trial');
xlabel('Times(ms)');
title('ISI Pick, r\_sethand\_090203Attrpaul1res2b')
axis tight
xl = xlim();
yl = ylim();
subplot(2,2,3);
all_events = {};
for ti = 1:length(threshes)
  events = extract_events_isi(spikes,threshes(ti));
  all_events = [all_events events];
  for e=events
    x = e.m-(e.s/2);
    y = ti - e.r/2;
    w = e.s;
    h = e.r;
    if w > 0 && h > 0
      rectangle('Position',[x y w h]);
    end
  end
end
%set(gca,'YTick',1:10:length(threshes));
%set(gca,'YTickLabel',threshes(1:10:length(threshes)));
set(gca,lax_style);
xlabel('Time(ms)')
ylabel('Threshold');
threshes(30)
xlim(xl)
ylim(yl)

ii = 37;
line(xl,[ii ii],'Color','r');

subplot(2,2,1);
events = all_events{ii};
xl = xlim;
yl = ylim;
for e=events
  line(e.bracket(1)*[1 1],yl,'Color','r');
  line(e.bracket(2)*[1 1],yl,'Color','g');
end

subplot(2,2,3);
mins = [];
maxs = [];
meds = [];
for i=1:size(spikes,1)
  ss = spikes(i,:,1);
  ss = sort(ss(ss>0));
  isi = diff(ss);
  mins = [mins min(isi)];
  maxs = [maxs max(isi)];
  meds = [meds median(isi)];
end
xl = xlim;
mmin = mean(mins);
mmax = mean(maxs);
mmed = mean(meds);
line(xl,[mmin mmin],'Color','b');
line(xl,[mmax mmax],'Color','b','LineWidth',3);
line(xl,[mmed mmed],'Color','b','LineWidth',1.5);






