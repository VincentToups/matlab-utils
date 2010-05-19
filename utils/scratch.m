
ms = [40 80 120];
ss = [3 3 3];
rr = [.9 .9 .9];
cs = { [1] [2] [1] }
nn = [50 50];

[spikes,bwr] = better_fake(ms,rr,ss,cs,nn)

ps =[];
kl =[];
ch =[];

for i=0:50
  nns = [nn(1)+i nn(2)-1];
  [spikes,w] = better_fake(ms,rr,ss,cs,nn);
  [sig,serr,psraw,pssurr] = pattern_sig(w,sum(w)/size(w,1),100);
  [chraw,serr,naught,chsurr] = chi_ps(w,100);
  [klsig,naught,klsurr] = kl_sig(w,100);
  
  ps = [ps distr_dist(pssurr,psraw)];
  kl = [kl distr_dist(klsurr,klsig)];
  ch = [ch distr_dist(chsurr,chraw)];
  
end

x = 1:50;
plot(x,ps,x,ch,x,kl);
legend('ps','ch','kl');

[ai,aj,av] = find(sta);
[oi,oj,ov] = find(sto);

for i=1:size(sta,1)
  ra = sta(i,:);
  ro = sto(i,:);
  la=length(find(ra>0));
  lo=length(find(ro>0));
  if la~=lo
    dispf('Lengths not equal on %d',i);
  end
end

%rr



