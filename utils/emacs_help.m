function emacs_help(nm)
d = help(nm)
if strcmp(d,'')
  emacs_eval('(print "matlab function %s not found or help is empty.")',nm);
else
  emacs_eval(['(progn (with-current-buffer (get-buffer-create "*Matlab-Help*")'...
    '(clear-buffer)'...
    '(insert "%s")) (switch-to-buffer-other-window "*Matlab-Help*"))'], strrep(d,'"','\"'));
end

