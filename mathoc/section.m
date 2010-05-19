function [name,hoc__]=section(params)
%
%
global hoc__
if ~exist('params')
  params = struct;
end

idf = @(x) x;

%inputname(1)

if strcmp(inputname(1),'') && (~isfield(params.name) || params.name == '')
  [str,name] = create_section(idf(params));
  add_to_section_list(name);
  %fprintf('recording %s:', name);
  %params
else
  eval(sprintf('%s = params; [str,name] = create_section(%s);', inputname(1), inputname(1)));
  if ~isfield(params,'name') || strcmp(params.name,'')
    add_to_section_list(inputname(1));
  else
    add_to_section_list(params.name);
  end
end
  
hoc__ = [hoc__ newline str newline];














