function grep(varargin)
%
%

if length(varargin) == 1
  varargin = [varargin {'*.m'}];
  warning('Searching m files by default.');
end

args = [ {'grep '} varargin ];

sy(args{:});
