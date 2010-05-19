function str=create_call(f_or_inst,varargin)
% STR=CREATE_CALL(F_OR_INST,VARARGIN)
% writes code to call a function or instance method with arguments converted to hoc



if isclass('char',f_or_inst)
  % function/procedure invocation
  args = ['(' join(map(@create_to_hoc, varargin)) ')'];
  str = sprintf(['%s' args], f_or_inst);
elseif isinstance(f_or_inst)
  % method invocation, second arg must be be a string corresponding to a method name
  args = ['(' join(map(@create_to_hoc, varargin(2:end))) ')'];
  str = sprintf(['%s.%s' args], f_or_inst.name, varargin{1});
end

