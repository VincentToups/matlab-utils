function dset=dataset(spikes, name, varargin)
% DATASET returns a new dataset object.
%   DSET=DATASET(SPIKES,NAME) creates a dataset for analysis with the 
%         spike pattern and event finding tools with the spike times in SPIKES
%         and with the name NAME.
%         DSET=DATASET(SPIKES,NAME,...) does the same as above but also accepts 
%         parameter/value pairs like the built-in matlab object-like constructs.
%         
%         The allowable paramter values are:
%
%         nt:       The number of trials to include in the analysis.
%
%         per:      The number of spikes desired per segment.
%
%         segparam: The ratio of the importantance of getting the right
%                   number of spikes in a segment to cutting the segments
%                   at low density cut points.
%
%         segbin:   The size of the bins used to estimate the spike rate
%                   in the segmentation procedure.
%
%         See Also:
%         all functions of the form ds*
%

if size(spikes,2) ~= 2
    spikes(:,:,2) = 0;
end

dset.dataset = spikes;
dset.name = name;

if mod(nargin,2)
    error('DATASEG called with an odd number of arguments.');
    return;
end

if nargin < 2
    error('DATASEG needs at least the start and end values of the segment.');
    return;
end

fieldnames =...
{   'nt',...
    'per',...
    'segparam',...
    'segbin',...
};

infields = varargin(1:2:end);

nbool = zeros( [length(infields),1] );
for i=1:length(infields)
    if ~strcmp( class( infields{i} ), 'char' )
        error(sprintf('Argument number %d is not a character array.', i*2+1));
        return;
    end
    tt = sum(strcmp(fieldnames,infields{i}));
    if tt > 1
        error(sprintf('Argument number %d is repeated.  Only one parameter/value pair should appear for each parameter.',i*2+1));
        return;
    elseif tt < 1
        error(sprintf('Argument number %d does not match any paramter.  Check documentation for allowed parameter values.',i*2+1));
        return;
    end
end

for i=1:length(fieldnames)
    switch fieldnames{i}
        case 'nt'
            
            ii = find(strcmp(infields,'nt'));
            if isempty(ii)
                dset.nt = size(spikes,1);
            else
                dset.nt = varargin{ii*2};
            end

        case 'per'
            
            ii = find(strcmp(infields,'per'));
            if isempty(ii)
                dset.per = 5;
            else
                dset.per = varargin{ii*2};
            end

        case 'segparam'

            ii = find(strcmp(infields,'segparam'));
            if isempty(ii)
                dset.segparam = 1/10;
            else
                dset.segparam = varargin{ii*2};
            end
        case 'segbin'
            ii = find(strcmp(infields,'segbin'));
            if isempty(ii)
                dset.segbin = 1;
            else
                dset.segbin = varargin{ii*2};
            end
    end
end

s = spikes(:,:,1);
s = s(s>0);
x = max(s);
y = min(s);
dset.segtimes = [floor(y) ceil(x)];
dset.nseg = 1;
dset.segs = dataseg(dset.segtimes(1),dset.segtimes(2));


