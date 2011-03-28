function [l,c,u,p] = fcmLabels(varargin)
%
%

[c,u,p] = fcm(varargin{:});
[non,l] = max(u,[],1);
