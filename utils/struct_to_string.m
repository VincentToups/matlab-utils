function str=struct_to_string(stru)

fields = fieldnames(stru);
str = ['struct('];
for fi=1:length(fields)
  field = {stru(:).(fields{fi})};
  str = [str to_emacs_string(fields{fi}) ','  to_emacs_string(field) ', '];
  if fi<length(fields)
    str = [str '...\n'];
  end
end
str = [str(1:end-2) ')'];


% fields = fieldnames(stru);
% str = ['struct('];
% for fi=1:length(fields)
%   field = stru.(fields{fi});
%   if ~strcmp(class(field),'cell')
%     str = [str to_emacs_string(fields{fi}) ', ' to_emacs_string(stru.(fields{fi})) ', '];
%   else
%     str = [str to_emacs_string(fields{fi}) ', {' to_emacs_string(stru.(fields{fi})) '}, '];
%   end
%   if fi<length(fields)
%     str = [str '...\n'];
%   end
% end

% str = [str(1:end-2) ')'];
