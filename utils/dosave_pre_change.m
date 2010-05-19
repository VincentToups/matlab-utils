function [output,h__]=dosave(params,rebuild__)

global dosave_directory__

if ~exist('rebuild__')
  rebuild__ = 0;
end

if isempty(dosave_directory__)
  dosave_directory__ = './dosave_data';
end

if ~isfield(params,'script_name') % compatability with old params.
  try
    r__ = which(params.do)
  catch
    r__ = [];
  end
  if ~isempty(r__)
    f__=fopen(r__);
    lines__ = {};
    while ~feof(f__)
      lines__{end+1} = fgetl(f__);
    end
    params.do_contents = lines__;
    fclose(f__);
  end
end

h__ = md5(params);
fprintf('params: \n');
params
str = to_emacs_string(params);
save('dwp','str');
fprintf('hashes to %s\n',h__);

name__ = [dosave_directory__ '/' h__ '.mat']
if isfield(params,'rebuild')
  rebuild__ = params.rebuild;
end
if exist(name__) == 2 && ~rebuild__
  load(name__);
  system(['touch ' name__]);
else
  unpack params;
  if ~isfield(params,'script_name') %compatability with old version
    eval(do);
  else
    script_name
    eval(script_name);
  end
  savenames__ = fieldnames(output);
  save(name__,savenames__{:});
end

retnames__ = fieldnames(params.output);
output = struct;
for i__=1:length(retnames__)
  output.(retnames__{i__})=eval(retnames__{i__});
end
