function varargout=call_memoized_kv(f,varargin)
% VARARGOUT=CALL_MEMOIZED_KV(F,VARARGIN) The same as CALL_MEMOIZED
%  except assumes that VARARGIN is a sequence of Key-Value pairs and
%  makes the memoization order independent in the order of keys.

stru = varargs_to_struct(varargin);
fns = sort(fieldnames(stru));
stru2 = struct;
for fi=1:length(fns)
  fn=fns{fi};
  stru2.(fn) = stru.(fn);
end
varargin = struct_to_varargs(stru2);

Params.output = struct;
for i=1:nargout
  params.output.(sprintf('out%d',i)) = 0;
end
out = fieldnames(params.output);

params.args = varargin;
params.f = f;
params.do = ['[' join(out)  '] = f(args{:});'];

[output,h__] = dosave(params);

for i=1:nargout
  varargout{i} = output.(sprintf('out%d',i));
end
