function vprint(string,varargin)
% VPRINTF(STRING,...) prints three copies of the figure
%  one in epsfiles, one in pepsfiles and one in jpgfiles
%  The figure in pepsfiles strips titles if they are anything
%  other than single characters.

global vprint_dest__
if isempty(vprint_dest__)
  vprint_dest__ = 'figures';
end

name = sprintf(string, varargin{:});

disp(name)

!mkdir epsfiles
!mkdir jpgfiles
!mkdir aifiles
!mkdir pepsfiles
!mkdir paifiles
!mkdir ppdffiles
!mkdir figfiles

hgsave(gcf,['figfiles/' name]);

print('-depsc','-adobecset', ['epsfiles/' name]);
try
  print('-dill', ['aifiles/' name]);
catch
  warning('Unable to print, probably because of OPENGL mode.')
end
print('-djpeg90',['jpgfiles/' name]);
print('-dpdf',['ppdffiles/' name]);


c = get(gcf,'Children');
strings = {};
for i=1:length(c)
    try
        t = get(c(i),'title');
        strings{i} = get(t,'string');
        if length(get(t,'string')) ~= 1
            set(t,'String','');
        end
    catch
        %pass
    end
end

print('-depsc','-adobecset', ['pepsfiles/' name]);
try
  print('-dill',['paifiles/' name]);
catch
  warning('Unable to print, probably because of OPENGL mode.')
end

for i=1:length(c)
    try 
        t = get(c(i),'title');
        set(t,'string',strings{i});
    catch
        %pass
    end
end

try
  eval(sprintf('!/home/toups/.bin/eps2svg %s %s', ['pepsfiles/' name '.eps'], ['psvgfiles/' name '.svg']));
catch
  %pass
end
