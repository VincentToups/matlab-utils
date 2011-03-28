function hs=plotDoubleWaveformData(volt,data,varargin)
%
%

defaults.offset = 10;
defaults.plotArgs = {};
defaults.smallPlotArgs = {};
defaults.largePlotArgs = {};
defaults.low = 1:499;
defaults.high = 500:1000;
defaults.labelOffsetZero = False;
defaults.markZero = False;
defaults.downsampleFactor = -1;

handle_defaults;

if isempty(smallPlotArgs)
  smallPlotArgs = plotArgs;
end

if isempty(largePlotArgs)
  largePlotArgs = plotArgs;
end

if downsampleFactor>0
  volt = downsample(volt,downsampleFactor);
  data = downsample(data,downsampleFactor);
  low = ceil(low/downsampleFactor)
  high = floor(high/downsampleFactor)
  size(volt)
  size(data)
end

h = plot(volt(low),data(low,:)+offset,smallPlotArgs{:});
hold on
hl = plot(volt(high),data(high,:),largePlotArgs{:});
hold off

minSmall = min(volt(low))
maxSmall = max(volt(low))
c = (maxSmall+minSmall)/2
w = maxSmall-minSmall
dotMin = c - (w/2)*1.2;
dotMax = c + (w/2)*1.2;

if markZero
  line([dotMin, dotMax],[offset offset],'Color','k','LineStyle','--','LineWidth',3);
end
if labelOffsetZero
  th =text(c+(w/2)*1.4, offset-.7, 'Zero');
  set(th,'FontSize',16);
end


hs = h;

