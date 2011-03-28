function h=subplotx(nh,nw,ix,jx)
%

if ~exist('jx','var')
  jx = ix(2);
  ix = ix(1);
end

ns = reshape(1:(nh*nw),[nw nh])';
h =subplot(nh,nw,ns(ix,jx));


