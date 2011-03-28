function updateEmacsMatlabDir()
%
%

p = tokenize(path(),':');
emacs_eval(['(setq *matlab-path* (list ' join(map(@(x)['"' x '"'], p),' ') ' ))' ]);


