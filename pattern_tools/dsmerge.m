function ds = dsmerge(ds,seginds)
% DSMERGE attempts to merge clusters of trials by significance.
%
% DS = DSMERGE(DS) attempts to merge the clusters represented in ds, which
%  has progressed to the point of having an event model, by comparing
%  clusters on a pairwise basis and calculating the increase in pattern
%  significance if a merger is attempted.
%
%  For each pair of clusters the quantity (s1+s2)/(2*st) is calculated,
%   where s1,2 are the significances of the two groups seperately and
%   st is the signficance of the groups combined.  A higher pattern
%   significance for the combined groups indicates an unfortuitous merger
%   and the above ratio will be less than one.
%
%  The enthusiasm with which this function merges clusters is determined by
%   a DATASEG parameter SIGMERGE which is the range around 1 for which mergers
%   are to happen according to the above score.
%
%  The DATASEG parameter SIGPASSES determines the number of passes 
%   which the merger goes through.  For each pass, all pairwise signficance
%   measures are calculated and mergers performed.  In the case that two
%   clusters may both be merged with a third, the merger with the best score
%   is taken.
%  If SIGPASSES is -1, the algorithm continues to make passes until no clusters
%   can be merged.
%
%   See Also:  DATASEG, DSIGSUBS, DSEGMERGE

dsconstants

if nargin==1
    seginds=dsgetseginds(ds,[],SIGFOUND,TERMINAL);
else
    seginds=dsgetseginds(ds,seginds,SIGFOUND);
end

for s=seginds
    pass = 1;
    done = 0;
    if ds.segs(s).sigpasses < 0
        passes = bitmax;
    else
        passes = ds.segs(s).sigpasses;
    end
    while pass < passes & ~done
        labels = ds.segs(s).tchosen;
        labels = relabel(labels);
        mx = max(labels) 
        spikes = ds.segs(s).eventform;
        scores = zeros([mx mx]);
        for i=1:mx
            ss = spikes(labels==i,:,:);
            size(ss)
            w = +(ss(:,:,1)>0);
            r = sum(w,1);
            r = r/size(w,1);
            jj = find(r);
            s1 = pattern_sig(w(:,jj),r(jj),10);
            for j=(i+1):mx
                ss = spikes(labels==j,:,:);
                w = +(ss(:,:,1)>0);
                r = sum(w,1);
                r = r/size(w,1);
                jj = find(r);
                s2 = pattern_sig(w(:,jj),r(jj),10);
                ss = spikes(labels == j | labels == i,:,:);
                w = +(ss(:,:,1)>0);
                r = sum(w,1);
                r = r/size(w,1);
                jj = find(r);
                st = pattern_sig(w(:,jj),r(jj),10);
                scores(i,j) = (s1+s2)/(2*st);
%                if isnan(sum([i,j,s1,s2,st,scores(i,j)]))
%                    disp(sprintf('i:%d\tj:%d\ts1:%d\ts2:%d\tst:%d\tscore:%d',i,j,s1,s2,st,scores(i,j)));
%                    keyboard
%                end
            end
        end
        
        scores(scores>1) = 1;
        disp('The scores are:');
        disp(scores);
        
        [is,js,vs] = find(scores);
        [vs,ii] = sort(vs);
        is = fliplr(flipud(is(ii)));
        js = fliplr(flipud(js(ii)));
        vs = 1-fliplr(flipud(vs));

        done = 1;
        while length(vs) > 0
            if vs(1) < ds.segs(s).sigmerge
                i = is(1);
                labels(labels==js(1)) = i;
                ii = find(is == is(1) | js == js(1));
                vs(ii) = [];
                is(ii) = [];
                js(ii) = [];
                done = 0;
            else
                vs = vs(2:end);
                is = is(2:end);
                js = js(2:end);
            end
        end
        ds.segs(s).tchosen = labels;
    end
end
ds = dsfindsig(ds,seginds);

