function seginds = dsgetseginds(ds,ii,minstate,clearstate)
% DSGETSEGINDS manages segment state indices.
%
% SEGINDS = DSGETSEGINDS(DS,[],MINSTATE,CLEARSTATE) returns the indices
%  which are at least MINSTATE but not greater than or equal to CLEARSTATE.
%  Prints a message describing which clusters these are.
%
% SEGINDS = DSGETSEGINDS(DS,II,MINSTATE) returns the intersection of the set
%  given by II and the set of segments whose status is greater than MINSTATE.
%  Prints a message indicating which segments these are.

if isempty(ii)
    stats = [ds.segs(:).status];
    seginds = find( stats >= minstate & stats < clearstate );
    fprintf('\nThe following segments will be updated:\n[ ');
    fprintf('%d ', seginds); fprintf(']\n\n');
    
    ii = find( stats < minstate );
    if ~isempty(ii)
        fprintf('These segments are not sufficiently processed for this step:\n[ ');
        fprintf('%d ',ii); fprintf(']\n\n');
    end

    ii = find( stats >= clearstate);
    if ~isempty(ii)
        fprintf('These segments are up to date already:\n[ ');
        fprintf('%d ', ii ); fprintf(']\n\n');
    end
else
    stats = [ds.segs(:).status];
    seginds = intersect(ii,find( stats >= minstate ));
    fprintf('\nThe following segments will be updated:\n[ ');
    fprintf('%d ', seginds); fprintf(']\n\n');
end

    
