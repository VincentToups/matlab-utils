function s=packstruct(into)

names = setdiff(evalin('caller', 'who')',{into});
names
for name = names
  name = name{1};
  evalin('caller', sprintf('%s.%s = %s;', into, name, name));
end
