function [output,h__]=dosave(params,rebuild__)

global dosave_directory__
global other_dosave_directories__ 
global sync_with_main_directory__ 
global dosave_verbose__ 
global dosave_force_rebuild__
global dosave_force_rebuild_detector__

if isempty(dosave_verbose__)
  dosave_verbose__ = 0;
end
if isempty(dosave_force_rebuild__)
  dosave_force_rebuild__ = 0;
end
if isempty(dosave_force_rebuild_detector__)
  dosave_force_rebuild_detector__ = @(p) 0;
end

dispf = @(s,varargin) warning(sprintf(s,varargin{:}));

if ~exist('rebuild__')
  rebuild__ = 0;
end

if isempty(dosave_directory__)
  dosave_directory__ = './dosave_data';
end

if isempty(other_dosave_directories__)
  other_dosave_directories__ = {};
end

if isempty(sync_with_main_directory__)
  sync_with_main_directory__ = 0;
end

if ~isfield(params,'script_name') % compatability with old params.
  try
    r__ = which(params.do);
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
%fprintf('params: \n');
%params
str = to_emacs_string(params);
%save('dwp','str');
%fprintf('hashes to %s\n',h__);

[rel_dir__,target_name__]=hash_to_location(h__);
abs_dir__ = [dosave_directory__ '/' rel_dir__];
name__ = [dosave_directory__ '/' rel_dir__ target_name__];
if isfield(params,'rebuild')
  rebuild__ = params.rebuild;
end

repeat__ = 1;
while repeat__
  if exist(name__) == 2 && ~rebuild__ && ~dosave_force_rebuild__ && ~dosave_force_rebuild_detector__(params)
    try
      load(name__);
      repeat__ = 0;
    catch
      warning(sprintf('dosave: Error loading %s, forcing a rebuild',name__));
      repeat__ = 1;
      rebuild__ = 1;
    end
    if dosave_verbose__, dispf('loading from %s', name__); end
    system(['touch ' name__]);
  else
    found_alt__ = 0;
    repeat__ = 0;
    for oi=1:length(other_dosave_directories__)
      other_dosave_directory__=other_dosave_directories__{oi};
      oname__ = [other_dosave_directory__ '/' rel_dir__ target_name__];
      if exist(oname__) == 2 && ~rebuild__
        found_alt__ = 1;
        load(oname__);
        if dosave_verbose__, dispf('loading from (alt) %s', oname__); end
        if sync_with_main_directory__
          system(sprintf('cp %s %s', oname__, name__));
          if ~exist(abs_dir__,'dir')
            system(['mkdir -p ' abs_dir__]);
          end
          
          if dosave_verbose__, dispf('syncing this file'); end
        end
      end
    end
    if ~found_alt__
      unpack_avoiding_keywords params;
      if ~isfield(params,'script_name') %compatability with old version
        eval(params.do);
      else
        %script_name
        eval(script_name);
      end
      savenames__ = fieldnames(output);

      if ~isdir(abs_dir__)
        system(['mkdir -p ' abs_dir__ '']);
      end
      try
        save(name__,savenames__{:});
      catch
        e=lasterror();
        disp(e);
        keyboard
      end
      if dosave_verbose__, dispf('saved data to %s', name__); end
    end
  end
end

retnames__ = fieldnames(params.output);
output = struct;
for i__=1:length(retnames__)
  output.(retnames__{i__})=eval(retnames__{i__});
end
