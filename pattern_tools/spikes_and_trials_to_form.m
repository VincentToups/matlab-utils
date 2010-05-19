function spikes=spikes_and_trials_to_form(spk,tri,nt)
%
%

uu = unique(tri);
spikes = [];
for ui=1:length(uu)
  tind = uu(ui);
  ss = spk(tri==tind);
  spikes = sloppycat(spikes, sort(ss), 1);
end

if exist('nt')
  if size(spikes,1)<nt
    spikes(nt,1) = 0;
  end
end
