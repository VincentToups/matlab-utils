function [ins,str]=create_instantiate(template, varargin)
% INS=CREATE_INSTANTIATE(TEMPLATE, ...)
%  creates an instance of TEMPLATE with args converted to HOC values

ins.instance = 1;
ins.name = new_unique_obj_name();

str = [ sprintf('objref %s',ins.name) newline ];
args = map(@create_to_hoc, varargin);
args = ['(' join(args) ')'];
if isclass('char',template)
  str = [str sprintf('%s = new %s',ins.name,template) args newline];
else
  str = [str sprintf('%s = new %s',ins.name,template.name) args newline];
end



