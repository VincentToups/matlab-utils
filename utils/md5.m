function cs=md5(ob)
%
%

global md5_verbose__
global md5_watchlist__ 
global md5_watchlist_map__

if isempty(md5_verbose__) 
  md5_verbose__ = 0;
end

if isempty(md5_watchlist__)
  md5_watchlist__ = {};
end

if isempty(md5_watchlist_map__)
  md5_watchlist_map__ = struct;
end

tmp = tempname;
f=fopen(tmp,'w');
fprintf(f,to_emacs_string(ob));
fclose(f);

if md5_verbose__
  fprintf('file to hash contents:\n')
  system(sprintf('cat %s',tmp));
end

otmp = tempname;
system(sprintf('md5sum %s > %s',tmp,otmp));
f=fopen(otmp);
line = fgetl(f);
fclose(f);
delete(otmp);
delete(tmp);
parts = {};
left = line;
while ~isempty(left)
  [tok,left] = strtok(left);
  parts{end+1} = tok;
end
sizes = map(@length,parts);
cs = filt(@(it) length(it)==32 && ~any('/'==it),parts);
if strcmp('cell',class(cs))
  cs = cs{1};
else
  cs = cs;
end

if any(strcmp(md5_watchlist__,cs))
  if md5_verbose__
    warning(sprintf('detected a hashing to %s from %s,',cs,to_emacs_string(ob)));
  end
  md5_watchlist_map__.(cs) = ob;
end
