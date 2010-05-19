function inst = instantiate(template, varargin)
% INST = INSTANTIATE(TEMPLATE, VARARGIN)
%  Generate code to instantiate an object and return an instance to keep track of it

global hoc__

[inst,str] = create_instantiate(template,varargin{:});

hoc__ = [hoc__ newline str];

