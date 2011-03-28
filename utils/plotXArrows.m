function hh=plotXArrows(x,y,span,varargin)

defaults.arrowLenFactor = .5;
defaults.arrowArgs = {'LineWidth',2,'Color','k'};
defaults.arrowRot = (2*pi)-(pi/6);

handle_defaults


for i=1:span:(length(x)-span)
  angle = atan2(y(i+1)-y(i),x(i+1)-x(i));
  xdiff = (abs(x(i+1)-x(i+span)))*arrowLenFactor;
  line([x(i) x(i)+(xdiff)*cos(angle+arrowRot)],[y(i) y(i)+(xdiff)*sin(angle+arrowRot)],arrowArgs{:});
  line([x(i) x(i)+(xdiff)*cos(angle-arrowRot)],[y(i) y(i)+(xdiff)*sin(angle-arrowRot)],arrowArgs{:});
end