function jprint(string,varargin)
% VPRINTF(STRING,...) prints three copies of the figure
%  one in epsfiles, one in pepsfiles and one in jpgfiles
%  The figure in pepsfiles strips titles if they are anything
%  other than single characters.

% disp(string)
% argstring = '';
% for i=1:length(varargin)
%     argstring = [argstring '''' varargin{i} ''','];
% end
% argstring = argstring(1:end-1);
% disp(argstring)
% if length(argstring) == 0
%     name = string;
% else
%     disp(['name = sprintf(''' string ''', ' argstring ');']);
%     eval(['name = sprintf(''' string ''', ' argstring ');']);
% end

name = sprintf(string, varargin{:});

disp(name)

!mkdir jpgfiles

print('-djpeg90',['jpgfiles/' name]);

