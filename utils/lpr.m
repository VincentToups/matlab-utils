function lpr(f)
% Moves things to the system lpr command on a linux box
%  makes a poopy on windows

if ~exist('f')
    f = '';
end


eval(['!lpr ' f]);



