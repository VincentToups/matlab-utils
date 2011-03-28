function h = plotXY(xy,varargin)

h = size(xy,1);
w = size(xy,2);
if h<w
  warning('You may need to transpose XY');
end
h = plot(xy(:,1),xy(:,2),varargin{:});