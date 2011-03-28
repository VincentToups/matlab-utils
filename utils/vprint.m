function vprint(string,varargin)
% VPRINTF(STRING,...) handles printing to a string formatted like printf
% vprint_dest__ is the destination of all figures, defaults to 'figures'
% vprint_jpg__ is a boolean.  Will print jpgs if 1.  defaults to 0
% vprint_fig__ is a boolean.  Will print figs if 1.  defaults to 0
% vprint_eps__ is a boolean.  Will print epss if 1.  defaults to 0
% vprint_png__ is a boolean.  Will print pngs if 1.  defaults to 1


global vprint_dest__ vprint_eps__  vprint_pdf__ vprint_jpg__  vprint_fig__ vprint_trim__ vprint_png__ vprint_notify_emacs__ vprint_check_printed__

if isempty(vprint_dest__)
  vprint_dest__ = 'figures';
end
global vprint_eps__
if isempty(vprint_jpg__)
  vprint_jpg__ = 0;
end
if isempty(vprint_fig__)
  vprint_fig__ = 0;
end
if isempty(vprint_eps__)
  vprint_eps__ = 0;
end
if isempty(vprint_png__)
  vprint_png__ = 1;
end

if isempty(vprint_pdf__)
  vprint_pdf__ = 1;
end


if isempty(vprint_trim__)
  vprint_trim__ = 1;
end

if isempty(vprint_check_printed__)
  vprint_check_printed__ = 0;
end

if isempty(vprint_notify_emacs__)
  vprint_notify_emacs__ = 1;
end

state = exist(vprint_dest__);
if state == 0 || state == 1
  mkdir(vprint_dest__);
  dirs = {'eps','jpg','fig','png','pdf'};
  for di=1:length(dirs)
    dir=dirs{di};
    mkdir(vprint_dest__,dir);
  end
end

name = sprintf(string, varargin{:});
name = strrep(name,'.','_');
fprintf('printing %s to %s\n', name, vprint_dest__);

if vprint_jpg__
  print('-djpeg90',[vprint_dest__ '/jpg/' name]);
  if vprint_trim__
    system(sprintf('mogrify -trim -fuzz 5%% %s/jpg/%s.jpg',vprint_dest__,name));
  end
end

if vprint_png__
  print('-dpng',[vprint_dest__ '/png/' name]);
  if vprint_trim__
    system(sprintf('mogrify -trim -fuzz 5%% "%s/png/%s.png"',vprint_dest__,name));
  end
end


if vprint_fig__
  hgsave(gcf,[vprint_dest__ '/fig/' name]);
end

if vprint_eps__
  print('-depsc','-adobecset', [vprint_dest__ '/eps/' name]);  
end

if vprint_pdf__
  print('-dpdf',[vprint_dest__ '/pdf/' name]);  
end


if vprint_notify_emacs__ && vprint_png__
  fullName = dircat(pwd,strrep([vprint_dest__ '/png/' name '.png'],'.png.png','.png'));
  fullName = fullName(1:(end-1));
  emacs_eval('(push-matlab-figure-onto-history "%s")', fullName);
end

if vprint_check_printed__
  emacs_eval('(open-last-matlab-figure)');
end
