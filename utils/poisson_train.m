function spikes = poisson_train(rt,n,tstop)

pts = cumsum(-log(rand([n ceil(5*(rt*tstop))]))/rt,2) - 2*tstop;
spikes = section_spikes(pts, [0 tstop]);
