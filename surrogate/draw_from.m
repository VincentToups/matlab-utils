function val = draw_from(list)
  list = list(:)';
  ii = ceil(rand(1)*length(list));
  val = list(ii);
%endfunction
