function xedit(filename, editor)
% FUNCTION MVIM(FILENAME) launches a VIM window to edit the specified file
% in the the current working directory in a new xterm process.

str = which(filename);

if ~exist('editor')
    editor = 'vim';
    opt = '';
else
    editor = 'emacs';
    opt = '-nw';
end
    

if strcmp(str, 'variable') | isempty(str)
    ii = find(filename=='.');
    if isempty(ii)
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
%system(sprintf('xterm -font 8x16 -T "%s: %s" -e %s %s %s &', editor, tstr, editor, opt, str));
%system(sprintf('mvim.py %s', str));
%es = sprintf('emacsclient.emacs-snapshot-gtk %s &', str);
% es = sprintf(['emacsclient -n %s &'], str);
% disp(es);
% system(es);

es = sprintf('(find-file-other-window "%s")',str);
emacs_eval(es);
