function [str,name]=create_section(params)
%
%
%

if ~exist('params')
  params = struct;
end

unpack params

if ~exist('name') || strcmp(name,'')
  if strcmp(inputname(1),'')
    name = new_unique_section_name;
  else
    name = inputname(1);
  end
end

if strcmp(name,'')
  name = new_unique_section_name;
end

%push = new_unique_obj_name;
%str = sprintf('objref %s',push);
%str = [str newline sprintf('%s = new SectionRef()',push)];
str = newline;
str = [str newline sprintf('create %s',name) newline sprintf('access %s', name)];
str = [str newline sprintf('objref %s',[name 'ref'])];
str = [str newline sprintf('%s = new SectionRef()', [name 'ref'])];
str = [str newline sprintf('%s {', name)];

variables = {'L', 'diam', 'nseg', 'Ra', 'cm'};
for vi=1:length(variables)
  if exist(variables{vi})
    str = [str newline sprintf('    %s=%f',variables{vi},eval(variables{vi}))];
  end
end

if exist('conductances')
  condnames = fieldnames(conductances);
  for ni=1:length(condnames)
    cname = condnames{ni};
    str = [str newline sprintf('    insert %s', cname)];
    fns = fieldnames(conductances.(cname));
    for fni=1:length(fns)
      str = [str newline sprintf('   %s = %f', fns{fni}, conductances.(cname).(fns{fni}))];
    end
  end
end

str = [str newline '}'];
%str = [str newline sprintf('access %s.sec()', push) newline];
