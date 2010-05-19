function [vv,ii]=findpeaks(f,n,p)
%
%
ii = [];
vv = [];
if nargin > 1
  for i=1:length(f)
    if ((i-n) >= 1) & (i + n <= length(f))
      pts = [f((i-1):(i-n)) f((i+1):(i+n))];
      if length(find(pts<f(i)))/length(pts) > p
        ii =[ii i];
        vv =[vv f(i)];
      end 
    end
  end
else
  fr = [f(1) f(1:end-1)];
  fl = [f(2:end) f(end)];

  %{
  subplot(2,2,1);
  plot(f-fl)
  hold on
  plot(f-fr,'r')
  hold off
  subplot(2,2,3);
  hold on
  plot(f,'g')
  plot(fl,'r')
  hold off
  subplot(2,2,2);
  plot(f-fr)
  subplot(2,2,4);
  hold on
  plot(f,'g')
  plot(fr,'r')
  hold off
  %}
  
  ii = find( ((f-fl) > 0) & ((f-fr) > 0));
  vv = f(ii);
end
    
