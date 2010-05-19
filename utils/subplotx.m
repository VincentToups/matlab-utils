function h=subplotx(nh,nw,ix,jx)
%


ns = reshape(1:(nh*nw),[nw nh])';
h =subplot(nh,nw,ns(ix,jx));


