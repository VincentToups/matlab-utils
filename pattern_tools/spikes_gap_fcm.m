function [cc,uu,pp]=spikes_gap_fcm(spikes,n,options)
%
%
%

nt = size(spikes,1);
spikes = spikes(spikes>0);

if ~exist('options')
  repeat = 30;
  options = [2 100 1e-5 0];%repmat(NaN,[1 4]);
  options(4) = 0;
  options(5) = 10;
end
  

[cc,uu,pp] = gap_fcm(spikes(:),n,@smartgap,options);
%[naught,naught,naught,gapfs,gs,ss,cc,uu,pp] = gap_fcm(spikes(:),n,@smartgap,options);
%ii = [];
%thresh = 0;
%mn = min(gapfs);
%mn = mn(1);
%dx = (0-mn)*.05;
%done = 0;
%found=0;
%while ~done
%  ii = find(gapfs>thresh);
%  i = 1;
%  if isempty(ii)
%    innerdone = 1;
%  else
%    innerdone = 0;
%  end
%  while ~innerdone
%    ind = ii(i);
%    probs = uu{ind};
%    [naught,labels] = max(probs,[],1);
%    rec = full(sparse(ones(size(labels)),labels,ones(size(labels))))./nt;
%    if ~any(rec>1)
%      innerdone = 1;
%      done = 1;
%      found = 1;
%    elseif i>length(ii)
%      innerdone = 1;
%    else
%      i = i + 1;
%    end
%  end
%  thresh=thresh-dx;
%  if thresh<mn
%    done =1;
%  end
%end
%
%if ~found
%  ii = 1;
%else
%  ii = ind;
%end
%
%cc = cc{ii};
%uu = uu{ii};
%pp = pp{ii};
