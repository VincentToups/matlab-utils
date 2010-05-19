function seg=dataseg(start,finish,varargin)
% DATASEG produces a new DATASEG psuedo-object.
%     SEG=DATASEG(start,finish) creates a segment objects with all the default
%     parameters to perform a clustering.  Due to limitations inherent in the
%     Matlab environment, this serves as little other than a place to store all
%     relavent parameters to a segment of data and a handle upon which to
%     perform clusterings.
%
%     DATASEG(start,finish,...) takes arguments not unlike the standard
%     built-in Matlab object -like constructs.  That is, as a list of string,
%     value pairs.
%     
%     EG:
%
%       DATASEG('q', logspace(-3, 0.2, 150), 'n', 2:5)
%
%     Would return a seg object with the specified logarithmic range of q
%     values and a parameter stating that cluster numbers from two to five
%     should be searched over.
%
%     Supported paramters are:
%     
%     metric_string:
%               A string which specifies how the metric is calculated
%               The default used the vpmetric and is 'vpmetric(spikes,q,k)'
%               Function which calculate the metric need to do so for many
%               values of q and k and returns a 4d array whose dimensions
%               are [N_K, N_Q, N_TRIALS, N_TRIALS].  This is a bit wonky
%               but its for legacy code.
%     
%     q:        A range of q values to search for clusters, roughly 
%               the importance of spike timing.
%
%     searchq:  Used to specify additional information for the 
%               trial clustering procedure.  By default, it sets the
%               spacing of search points and the minimum density of search
%               points for use with the DSTRIALCLUSTER_SEARCH function.
%               
%     k:        A range of k values to search, roughly the importance
%               of spike label
%
%     n:        A range of integer number of cluster values to search
%
%     r:        The number of times to repeat each clusterings.
%
%     coptions: FCM options for trial clustering
%               coptions(1):    fuzzyness [2]
%               coptions(2):    max iterations [1000]
%               coptions(3):    convergence criteria [1e-5]
%               coptions(4):    verbose mode { [0] | 1 }
%                               verbose mode is disabled for myfcm
%
%     cpca:     Whether to reduce the dimensionality of the metric space
%               before clustering using principle component analysis.
%               Set to -1 to turn off PCA, otherwise specify the number of
%               components to keep (a good ballpark is 20).
%     
%     hood:     The number of previous clusterings to compare a given cluster
%               to in order to decide if it is unique enough to be kept.
%     
%     sameness: As each cluster is found, it is compared to the HOOD 
%               previous kept clusterings to see if it unique enough to keep.
%               This is done by caclulating the mutual information between the
%               two clusterings, a quantity which is 1 if the clusterings are
%               identical and zero if they are completely independent.  The
%               sameness factor is the minimum information between two
%               clusterings below which the clusterings are considered
%               discreet.  A sameness of .9 corresponds very roughly to 90%
%               correlation between the two clusterings.
%
%     cfitstr:  A string which, when evaluated, produces a fitness measure
%               from the output variables of myfcm.  In the scope where this
%               string is executed, these variables are c, the cluster centers
%               u, the probabilities of each trial to belong in each cluster,
%               and e the objective function values for each iteration.  I
%               suggest writing functions of u,e,c and making them available on
%               the path, and then passing the string representing the function
%               call.
%
%               EG: cfitstr = 'fitness(u)';
%
%     cmerge:   For two clusters, how similar clusters should be before they 
%               merge.  Clusters whose average occupancies are closer than this
%               number will be automatically merged.
%
%     sn:       List of the number of clusters to try while clustering spike
%               times.
%
%     sr:       The number of times to repeat the spike clusterings.
%
%     svw:      The Spike Vector Weights.  The vector used for spike time
%               sorting is [s tpr tpo] where s is the spike time, tpr is the
%               time to the previous spike (or simply t, if s is the first
%               spike) and tpo is the time to next spike.  Each dimension is
%               rescaled to have mean .5 and standard deviation one, then they
%               are all multiplied by a vector [1 svw], in which svw is a 1x2
%               matrix describing the weight of importance for the tpr, tpo
%               dimension compared to the spike time.
%
%     spikevstr:This is a string which when evaluated in the context of a 
%               variable called "spikes" containing spike times produces a set
%               of vectors to be sorted by fcm.  If this is '', then the scheme
%               described above is used.  If the user wishes to pass in
%               parameters for this process, they may use the svw variable as a
%               cell array, for example, to accomplish this.  eg:
%               dseg.spikevstr = 'makevects(spikes, svw)' Where makevects is a
%               function in the global scope which returns an M-by-N matrix
%               where M is the number of spikes and N is the number of data
%               points.  Order of spike times should be preserved as that of
%               spikes(:).
%
%     ssameness:This variable dictates the percentage of similarly classified 
%               spikes below which a clustering is considered distinct from
%               another. 
%
%     smerge:   For two clusters of spikes times (hence the 's'), how similar
%               clusters should be before they should be merged.  This follows
%               the same logic  as the cmerge parameter.
%
%     sfitstr:  A string which when evaluated produces a cluster fitness 
%               measure from the output variables of myfcm and three other
%               variables: sd, ss and ssz, which will be available in the scope
%               where the the string is evaluated.
%
%     sd:       The penalty for clusterings with double occupancy.  Each 
%               instance of double occupancy incurs this penalty.  Of course,
%               when used in conjunction with sfitstr, sd may have any meaning
%               which the supplied fitness measure can deal with.
%
%     ss:       The penalty for clusterings with very small clusters, as 
%               defined by ssz.  Each instance which falls below the size
%               specified by ssz will incur this penalty.  Of course, when used
%               in conjunction with sfitstr, ss may have any meaning which the
%               supplied fitness measure can deal with.
%
%     ssz:      The minimum size a cluster must be larger than not to 
%               incur the fitness penalty ss.  If ssz >= 1 it is interpreted as
%               a number of spikes.  If ssz < 1 it is interpreted as a
%               percentage of the number of trials in the dataset in which the
%               cluster is occupied.
%
%     soptions: FCM options for spike time clustering.  Same as above.
%     
%     sosz:     The minimum size a cluster must exceed to not be considered 
%               an outlier.  Outliers are not considered in the calculation of
%               reliability and precision, and they will not be shown in the
%               event picker.
%
%     sigmerge: a parameter which controls the merging of clusters in the
%               DSMERGE function.  This should be a number on the order of .1,
%               and larger values of sigmerge lead to more aggressive merging
%               of clusters.
%
%     sigpasses: 
%               The number of passes used in the DSMERGE function.
%
%     sigsplit: Attempts to split clusters with low significance 
%               by moving their trials into the clusters which they
%               are closest to in the sense of the VPMETRIC
%
%   See also DSMERGE, DSSIMPLESPLIT, DATASET, FCM, VPMETRIC, and
%       pretty much everything else in the software package.
%


if mod(nargin,2)
    error('DATASEG called with an odd number of arguments.');
    return;
end

if nargin < 2
    error('DATASEG needs at least the start and end values of the segment.');
    return;
end


fieldnames =...
{   'q',...
    'metric_string',...
    'searchq',...
    'k',...
    'n',...
    'r',...
    'coptions',...
    'cpca',...
    'hood',...
    'sameness',...
    'cfitstr',...
    'cmerge',...
    'sn',...
    'sr',...
    'svw',...
    'spikevstr',...
    'ssameness',...
    'smerge',...
    'sfitstr',...
    'sd',...
    'ss',...
    'ssz',...
    'soptions',...
    'sosz',...
    'sigmerge',...
    'sigpasses',...
    'sigsplit'...
    
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

seg.start = start;
seg.finish=finish;


for i=1:length(fieldnames)
    switch fieldnames{i}
        case 'q'
        
            ii = find(strcmp(infields,'q'));
            if isempty(ii)
                seg.q = logspace(-3,log10(1.5),150);
            else
                seg.q = varargin{ii*2};
            end
        case 'metric_string'
            ii = find(strcmp(infields,'metric_string'));
            if isempty(ii)
                seg.metric_string = 'vpmetric(spikes,q,k);';
            else
                seg.metric_string = varargin{ii*2};
                if seg.metric_string(end) ~= ';'
                    seg.metric_string = [seg.metric_string ';'];
                end
            end
        case 'searchq'
            
            ii = find(strcmp(infields,'searchq'));
            if isempty(ii)
                seg.searchq = [.1 .001];
            else
                seq.searchq = varargin{ii*2};
            end
            
        case 'k'
        
            ii = find(strcmp(infields,'k'));
            if isempty(ii)
                seg.k = 0;
            else
                seg.k = varargin{ii*2};
            end
        case 'n'

            ii = find(strcmp(infields,'n'));
            if isempty(ii)
                seg.n = 2:5;
            else
                seg.n = varargin{ii*2};
            end

        case 'r'

            ii = find(strcmp(infields,'r'));
            if isempty(ii)
                seg.r = 5;
            else
                seg.r = varargin{ii*2};
            end
    
        case 'cfitstr'

            ii = find(strcmp(infields,'cfitstr'));
            if isempty(ii)
                seg.cfitstr = 'fitness(u)';
            else
                seg.cfitstr = varargin{ii*2};
            end

        case 'cmerge'

            ii = find(strcmp(infields,'cmerge'));
            if isempty(ii)
                seg.cmerge = .05;
            else
                seg.cmerge = varargin{ii*2};
            end

        case 'coptions'
            
            ii = find(strcmp(infields,'coptions'));
            if isempty(ii)
                seg.coptions = [2 1000 1e-5 0];
            else
                seg.coptions = varargin{ii*2};
            end

        case 'cpca'

            ii = find(strcmp(infields,'cpca'));
            if isempty(ii)
                seg.cpca = 20;
            else
                seg.cpca = varargin{ii*2};
            end

        case 'hood'

            ii = find(strcmp(infields,'hood'));
            if isempty(ii)
                seg.hood = 0;
            else
                seg.hood = varargin{ii*2};
            end

        case 'sameness'
            
            ii = find(strcmp(infields,'sameness'));
            if isempty(ii)
                seg.sameness = .9;
            else
                seg.sameness = varargin{ii*2};
            end

        case 'sn'
        
            ii = find(strcmp(infields,'sn'));
            if isempty(ii)
                seg.sn = 2:15;
            else
                seg.sn = varargin{ii*2};
            end

        case 'sr'

            ii = find(strcmp(infields,'sr'));
            if isempty(ii)
                seg.sr = 5;
            else
                seg.sr = varargin{ii*2};
            end

        case 'svw'
            
            ii = find(strcmp(infields,'svw'));
            if isempty(ii)
                seg.svw = [.2 .2];
            else
                seg.svw = varargin{ii*2};
            end

        case 'spikevstr'
            
            ii = find(strcmp(infields,'spikevstr'));

            if isempty(ii)
                seg.spikevstr = 'smakevectprpo(spikes,svw)';
            else
                seg.spikevstr = varargin{ii*2};
            end

        case 'ssameness'
            
            ii = find(strcmp(infields,'ssameness'));

            if isempty(ii)
                seg.ssameness = .9;
            else
                seg.ssameness = varargin{ii*2};
            end
            
        case 'smergre'

            ii = find(strcmp(infields,'smerge'));
            if isempty(ii)
                seg.smerge = .05;
            else
                seg.smerge = varargin{ii*2};
            end

        case 'sfitstr'

            ii = find(strcmp(infields,'sfitstr'));
            if isempty(ii)
                seg.sfitstr = 'spikefitness(spikes,u,ss,sd,ssz)';
            else
                seg.sfitstr = varargin{ii*2};
            end

        case 'sd'
            
            ii = find(strcmp(infields,'sd'));
            if isempty(ii)
                seg.sd = -0;
            else
                seg.sd = varargin{ii*2};
            end

        case 'ss'

            ii = find(strcmp(infields,'ss'));
            if isempty(ii)
                seg.ss = -0;
            else
                seg.ss = varargin{ii*2};
            end

        case 'ssz'

            ii = find(strcmp(infields,'ssz'));
            if isempty(ii)
                seg.ssz = .1;
            else
                seg.ssz = varargin{ii*2};
            end

        case 'soptions'

            ii = find(strcmp(infields, 'soptions'));
            if isempty(ii)
                seg.soptions = [2 1000 1e-5 0];
            else
                seg.options = varargin{ii*2};
            end

        case 'sosz'

            ii = find(strcmp(infields, 'sosz'));
            if isempty(ii)
                seg.sosz = .01;
            else
                seg.sosz = varargin{ii*2};
            end
        
        case 'sigmerge'

            ii = find(strcmp(infields,'sigmerge'));
            if isempty(ii)
                seg.sigmerge = .1;
            else
                seg.sigmerge = varargin{ii*2};
            end

        case 'sigpasses'

            ii = find(strcmp(infields,'sigpasses'));
            if isempty(ii)
                seg.sigpasses = -1;
            else
                seg.sigpasses = varargin{ii*2};
            end

        case 'sigsplit'

            ii = find(strcmp(infields,'sigsplit'));
            if isempty(ii)
                seg.sigsplit = .1;
            else
                seg.sigsplit = varargin{ii*2};
            end






    end

end

seg.status = 0;

