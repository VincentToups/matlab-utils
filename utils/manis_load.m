function traces=manis_load(file)
% TRACES = MANIS_LOAD(FILE) loads data stored in the format
%  of the Manis Lab at UNC-CH.

load(file);
dbs = whos('db_*');
dbs = { dbs(:).name };
traces = [];
for i=1:length(dbs)
disp(sprintf('Loading db_%d.',i));
    eval(sprintf('dbt = db_%d;', i));
    for j=1:length(dbt)
%        disp('manis_load')
%        disp(j)
        fn = fields(dbt{j});
        fn = fn{1};
        trace = dbt{j}.(fn).data(:,1);
        sc = size(traces,1);
        sn = size(trace,1);
        if sc < sn & i ~= 1
            traces(sn,end) = 0;
        elseif sn < sc & i ~= 1
            trace(sc) = 0;
        end
        traces = [traces trace];
    end
end

