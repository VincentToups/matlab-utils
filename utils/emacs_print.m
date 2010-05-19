function emacs_print(str)

str = sprintf('emacsclient --no-wait --eval "(print \\"%s\\")"',str);
system(str);
