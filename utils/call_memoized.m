function [varargout]=call_memoized(f,varargin)
% [VARARGOUT]=CALL_MEMOIZED(F,VARARGIN)
%  Wraps a call to F through the disk memoization system keyed by VARARGIN

params.output = struct;
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
