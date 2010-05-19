function [p,ps,sigs]=jitschr(sp,sigs,precthresh)

sp = sp(:,:,1);
cnts = sum(sp>0,2);
cnts = cnts(:)';
sp = sp(cnts>0,:);
if ~exist('sigs') || isempty(sigs)
  sigs = [linspace(.1,100,100) 100];
end
if isempty(sp)
  p = 0;
  ps = zeros(size(sigs));
end

selspik = 1:size(sp,1);

if ~exist('precthresh')
  precthresh = .68;
end

trindx=find(triu(ones(length(selspik)),1)>0);
RR = cschrieber(sp,sigs,1) ;
RR=permute(squeeze(RR),[2 3 1]);
RR=reshape(RR,[size(RR,1)^2 size(RR,3)]);
ps=mean(RR(trindx,:),1);
ps=ps/ps(end);
ii=find(ps>precthresh);
if isempty(ii)
  p = sigs(end);
  return
end
intabove = ps(ii(1));
if ii(1) == 1
  p = sigs(1);
  return
end

intbelow = ps(ii(1)-1);
if intbelow==precthresh
  p = sigs(ii(1)-1);
  return
end
d2 = intabove-precthresh;
d1 = precthresh - intbelow;
p = sigs(ii(1)-1) + d1/(d2+d1);



