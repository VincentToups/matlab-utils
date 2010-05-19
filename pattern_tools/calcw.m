function w = calcw(data,inds)
  un = unique(inds);
  w = 0;
  for i=1:length(un)
    c = un(i);
    subdata = data(inds==c,:);
    [naught, bunch] = pairdists(subdata);
    w = w + (1/(2*size(subdata,1)))*sum(bunch);
  end
%endfunction
