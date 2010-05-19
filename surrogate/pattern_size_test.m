ms = [40 80 120];
ss = [3 3 3];
rr = [.9 .9 .9];
cs = { [1] [2] [1] }
nn = [50 50];

[spikes,bwr] = better_fake(ms,rr,ss,cs,nn)

ps =[];
kl =[];
ch =[];

for i=0:49
  nns = [nn(1)+i nn(2)-i];
  p =[];
  k =[];
  c =[];
  for j=1:1000
      if j==1
        pssurr = 100;
        chsurr = 100;
        klsurr = 100;
      end
      [spikes,w] = better_fake(ms,rr,ss,cs,nns);
      [sig,serr,psraw,pssurr] = pattern_sig(w,sum(w)/size(w,1),pssurr);
      [chraw,serr,naught,chsurr] = chi_ps(w,chsurr);
      [klsig,naught,klsurr] = kl_sig(w,klsurr);
      p = [p distr_dist(pssurr,psraw)]; 
      k = [k distr_dist(klsurr,klsig)]; 
      c = [c distr_dist(chsurr,chraw)];
      
  end
  ps =[ ps mean(p)];
  kl =[ kl mean(k)];
  ch =[ ch mean(c)];
end
x = 0:49;
plot(x,ps,x,ch,x,kl);
legend('ps','ch','kl');
vprint('measure_test_pattern_size');
