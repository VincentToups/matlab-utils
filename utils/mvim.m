function mvim(filename)
% FUNCTION MVIM(FILENAME) launches a VIM window to edit the specified file
% in the the current working directory in a new xterm process.

str = which(filename);

if strcmp(str, 'variable') | isempty(str)
    ii = find(filename=='.');
    if isepmty(ii)
        str = [filename '.m'];
    else
        str = filename;
    end
    disp(sprintf('Opening %s...', str));
elseif strcmp(str,'build-in')
    disp(sprintf('%s is a built-in function...',filename));
    return;
else
    disp(sprintf('Opening %s...', str));
end

ii = find( str == '/' );
if length(ii)>1
    ii = ii(end-1);
    tstr = str(ii:end);
else
    tstr = str;
end
system(sprintf('xterm -T "vim: %s" -e vim %s &', tstr, str));



