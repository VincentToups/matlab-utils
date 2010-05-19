function kassert(statement, message)
% KASSERT Functions sort of like C Assert statements.
%
% KASSERT(STATEMENT, MESSAGE) produces a warngin with MESSAGE
% if STATEMENT is FALSE.  Also executes KEYBOARD in the calling
% workspace.
%

if ~statement
evalin('caller',sprintf('warning(''%s'')',message));
evalin('caller','whos; keyboard');
end



