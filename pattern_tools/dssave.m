function dssave(ds,directory)
% DSSAVE(DS) simply executes "save ds.name ds"
% DSSAVE(DS,DIR) executes "save DIR/ds.name" note that 
% the directory should not be terminated with a "/"
% the default directory is simple '.'

if ~exist('directory')
    directory = '.';
end

disp(['save ' directory '/' ds.name ' ds'])
eval(['save ' directory '/' ds.name ' ds'])


