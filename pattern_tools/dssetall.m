function ds = dssegset(ds,varargin)
% DSSETALL is a name/value setter for DATASET objects
%
% DS = DSSETALL(DS,'name',value,'name',value,...) sets the segment
%   properties specified by each name to the values given.  Valid
%   name/value pairs can be read in the help documentation for 
%   DATASEG.  Type 'help dataseg'.  All segments are set.
%
% DS = DSSETALL(DS,SEGSTRUCT) uses the fields of SEGSTRUCT to
%   set the values of all the segments.  Any fields not listed in
%   segstruct will be left unchanged.
%
% DS = DSSETALL(DS,II,'name',value,'name',value,...) sets only
%   those segments specified by the indices II with the given
%   name/value pairs.
%
% DS = DSSETALL(DS,II,SEGSTRUCT) uses the fields of SEGSTRUCT to
%   set the values of the segments specified by II.
%
% See also DATASET
% WARNING: Slightly out of date: it is easier to just address the
% DATASET directly with colons and subscripting.

if nargin < 2
    error('DSSEGSET called with fewer than 2 arguments.');
    return;
end

fieldnames =...
{   'q',...
    'k',...
    'n',...
    'cfitstr',...
    'cmerge',...
    'coptions',...
    'cpca',...
    'sn',...
    'smerge',...
    'sfitstr',...
    'sd',...
    'ss',...
    'ssz',...
    'soptions',...
    'sosz'...
};

redo_trial_clus =...
{   'q',...
    'k',...
    'n',...
    'cfitstr',...
    'coptions',...
    'cpca'...
};

redo_trial_merge = {'cmerge'};

redo_spike_clus =...
{   'sn',...
    'sfitstr',...
    'sd',...
    'ss',...
    'ssz',...
    'soptions',...
    'sosz'...
};

redo_spike_merge = {'smerge'};

if strcmp(class(varargin{1}), 'double')
    ii = varargin{1};
    args = varargin{2:end};
else
    ii = 1:ds.nseg;
    args = varargin{1:end};
end

if strcmp(class(args{1}),'struct')
    nm = fields(args{1});
    for n=nm
        if any(strcmp(n,fieldnames))
            ds.segs(ii).(nm) = args{1}.(nm);
            if any(strcmp(n,redo_trial_clus))
                ds.segs(ii).status = 0;
            elseif any(strcmp(n,redo_trial_merge))
                ds.segs(ii).status = 1;
            elseif any(strcmp(n,redo_spike_clus))
                ds.segs(ii).status = 2;
            elseif any(strcmp(n,redo_spike_merge))
                ds.segs(ii).status = 3;
            end
        else
            error(sprintf('DSSEGSTE error: %s not a valid field name.', n));
        end
    end
else
    if mod(nargin,2)
        error('DATASEG called with an odd number of arguments.');
        return;
    end
    nm = args{1:2:end};
    vv = args{2:2:end};
    for i=1:length(nm)
        if any(strcmp(n,fieldnames))
            ds.segs(ii).(nm{i}) = vv{i};
            if any(strcmp(nm{i},redo_trial_clus))
                ds.segs(ii).status = 0;
            elseif any(strcmp(nm{i},redo_trial_merge))
                ds.segs(ii).status = 1;
            elseif any(strcmp(nm{i},redo_spike_clus))
                ds.segs(ii).status = 2;
            elseif any(strcmp(n{i}, redo_spike_merge))
                ds.segs(ii).status = 3;
            end
        else
            error(sprintf('DSSEGSTE error: %s not a valid field name.', n));
        end
    end
end

return;

 








 
