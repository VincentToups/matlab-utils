function pos=insert_layout()

f = gcf;
cs = get(f,'Children');
pos = [];
xs = [];
ys = [];
to_insert = {};
for ci=1:length(cs)
  c=cs(ci);
  to_insert{ci} = ...
      sprintf(['axes(''position'',[' sprintf('%d ', get(c,'position')) ']);\n'],...
              ci);
  p = get(c,'position');
  pos = [pos; p];
  xs = [xs p(1)];
  ys = [ys p(2)];
end

ind = .01*xs - ys;
[nothing, ii] = sort(ind);
to_insert = to_insert(ii);
for ti=1:length(to_insert)
  item=to_insert{ti};
  emacs_insert(['a%d = ' item],ti);
end
