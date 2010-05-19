function [dists,bunch]=pairdists(vects)

bunch = pdist(vects);
dists = squareform(bunch);
