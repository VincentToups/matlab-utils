function tf=strcmp_caseless(s1,s2)

if strcmp(class(s1),'cell')
  s1 = map(@lower,s1);
else
  s1 = lower(s1);
end
if strcmp(class(s2),'cell')
  s2 = map(@lower,s2);
else
  s2 = lower(s2);
end

tf = strcmp(s1,s2);
