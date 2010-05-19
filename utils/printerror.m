function printerror(e)
%

disp('error:');
if length(e.stack) > 0
  dispf('%s in %s at line %d',e.message, e.stack(1).file, e.stack(1).line);
  for i=2:length(e.stack)
    disp('From:')
    dispf('\t%s at line %d',e.stack(i).file, e.stack(i).line);
  end
else
  disp(e.message);
end
