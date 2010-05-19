function [c,u,p,gapf,g,s,cs,us,ps]=gap_fcm(data,n,decfun,options)
if ~exist('options')
  repeat = 100;
  options = [2 100 1e-5 0];%repmat(NaN,[1 4]);
  options(4) = 0;
else
  repeat = options(5);
end
if ~exist('')
  decfun = @simplegap;
end

n = n + 1; % we must go one higher than what the user wants
g = repmat(0,[1 n]);
s = g;
cs = {};
us = {};
ps = {};
[svdu,svds,svdv] = svd(data);
for nc=1:n
  [cs{nc},us{nc},ps{nc}] = repfcm(data,nc,options);
  [naught,labels] = max(us{nc},[],1);
  wreal = calcw(data,labels);
  nullws = repmat(0,[1 repeat]);
  for i=1:repeat
    data_null = nullify_data_svd(data,svdu,svds,svdv);
    [cn,un,pn] = fcm(data_null,nc,options);
    [naught,labels] = max(un,[],1);
    nullws(i) = calcw(data_null,labels);
  end
  g(nc) = mean(log(nullws)-log(wreal));
  s(nc) = std(log(nullws))*sqrt(1 + 1/repeat);
end
gapf = g(1:(end-1)) - g(2:end) + s(2:end);
%nc = find(gapf>0);
decfun
nc = decfun(g,s);
nc
if ~isempty(nc)
  nc = nc(1);
else
  nc = 1;
  %[nc,ii] = max(gapf);
  %nc = ii(1)
end
c = cs{nc};
u = us{nc};
p = ps{nc};
%endfunction 
