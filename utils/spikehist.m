function varargout = spikehist(spikes, varargin)
%
%

data = spikes(spikes>0);

if nargout()
  varargout{:} = hist(data, varargin{:});
else
  hist(data, varargin{:});
end

