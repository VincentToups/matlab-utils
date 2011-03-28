function data=deFlicker(data,varargin)
%
%

defaults.flickerWindow = 10;
defaults.replaceBy = 'meanNeighbors';
defaults.repeat = 3;
defaults.sigmaMult = 2;

handle_defaults;

repeat;
for rrr=1:repeat
  n = size(data,2);
  for i=1:(floor(n/flickerWindow))
    %if i==floor(n/flickerWindow)
    %  inds = (inds(end)+1):n;
    %else
      inds = (1:flickerWindow) + (i-1)*flickerWindow;
    %end
    slice = data(:,inds);
    meds = repmat(median(slice,2),[1 flickerWindow]);

    try
      stad = repmat(sqrt(median((slice-meds).^2,2)),[1 flickerWindow]);
    catch
      keyboard
    end
    [qs,rs,vv] = find( sqrt((slice-meds).^2)>sigmaMult*stad);
    for qi=1:length(qs)
      q=qs(qi);
      r=rs(qi);
      switch r
       case 1
        slice(q,r) = slice(q,r+1);
       case flickerWindow
        slice(q,r) = slice(q,r-1);
       otherwise
        slice(q,r) = mean([slice(q,r+1) slice(q,r-1)]);
      end
    end
    data(:,inds) = slice;
  end
end