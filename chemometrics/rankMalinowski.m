function [n,aux] = rankMalinowski(data,varargin)
% expects data to be NxM where M is number of dimensions,
%  and N is the number of trials.

defaults.alphaStat = .05;
defaults.alsoReturn = 'all';
handle_defaults;


r = size(data,1);
c = size(data,2);

[v,d] = eig(cov(data));
d = sum(d,1);
d = d(:)';
d = sort(d,'descend');
j = 1:length(d);
red = d./((r-j+1).*(c-j+1));

done = False;
s = min([r c])-1;
rankEst = s - 1;
erEigInd = s;


while ~done
  j = (rankEst+1):s;
  num = sum((r-j+1).*(c-j+1))*d(rankEst);
  den = (r-rankEst+1)*(c-rankEst+1)*sum(d(j));
  f = num/den;
  fun = @(x) fcdf(x,1,s-rankEst)-(1-alphaStat);
  fSig = fzero(fun,0);
  if f>fSig
    done = True;
  else
    erEigInd = [rankEst erEigInd];  
    rankEst = rankEst-1;
  end
  if rankEst == 0
    done = True;
  end
end
n = rankEst;

if nargout > 1
  if ischar(alsoReturn)
    if strcmp(alsoReturn,'all')
      alsoReturn = who;
    else
      alsoReturn = {alsoReturn};
    end
  end

  aux = struct;
  for ai=1:length(alsoReturn)
    item=alsoReturn{ai};
    aux.(item) = eval([item ';']);
  end
end
