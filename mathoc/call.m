function [hoc__]=call(varargin)
% [HOC__]=CALL(VARARGIN)
%  generates and inserts code to call a hoc function or method

global hoc__
hoc__ = [hoc__ newline create_call(varargin{:}) newline];

