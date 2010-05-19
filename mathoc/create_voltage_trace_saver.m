function [str,name,filename]=create_voltage_trace_saver(params)
%
%

if ~exist('params')
  params = struct;
end

fn = fieldnames(params);
for fni=1:length(fn)
  eval(sprintf('%s = params.%s;',fn{fni},fn{fni}));
end

if ~exist('name') || ( exist('name') && isempty(name))
  name = new_unique_obj_name();
end

if ~exist('sectionname') || ( exist('sectionname') && isempty(sectionname)) 
  sectionname = 'soma';
end

if ~exist('location') || ( exist('location') && isempty(location))
  location = .5;
end

if ~exist('filename') || ( exist('filename') && isempty(filename))
  filename = [sprintf('/tmp/%s%d', sectionname, round(location*100)) strrep(foldl(@(it,ac) ['-' it ac], '', map(@num2str, fliplr(clock))),'.','_') '.trace'];
end

if ~exist('vtmode') || ( exist('vtmode') && isempty(vtmode))
  vtmode = 'a';
end

if ~exist('varname') || (exist('varname') && isempty(varname))
  str = sprintf('objref %s\n', name);
  str = [str sprintf('%s = newVoltageTraceSaverName("%s","%s", %f, "%s")\n', name, vtmode, sectionname, location, filename)];
else
  str = sprintf('objref %s\n', name);
  str = [str sprintf('%s = newVoltageTraceSaverName("%s","%s", %f, "%s","%s")\n', name, vtmode, sectionname, location, filename, varname)];
end


