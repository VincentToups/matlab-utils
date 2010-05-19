spikes = load_uneven_spikes('distribution_data/disttestdata1.spikes');
rast(spikes);

ss = section(spikes,[350 450]);

rast(ss)
ss = ss(:,1);
ss = reshape(ss,[10 4])

m = [];
r = [];
s = [];
for i=1:size(ss,2)
  sss = ss(:,i);
  sss = sss(sss>0);
  sss
  m = [m mean(sss)];
  r = [r length(sss)/10];
  s = [s std(sss)];
end

subplot(3,1,1);
plot(m)
subplot(3,1,2);
plot(r)
subplot(3,1,3);
plot(s)

ss
r

%%%> 
