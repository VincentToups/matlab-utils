function r = testHandleDefaultsFn(varargin)
% passing in a default arg not listed in defaults will cause an error.
% this is to prevent you from passing in a similar looking variable
% and getting confused about why it doesn't work.

defaults.a = 10;
defaults.b = 11;
defaults.c = 12;

handle_defaults;

r = {a,b,c};