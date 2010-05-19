while (1)

    !touch ~/.mlcom/started;
    fh = fopen('~/.mlcom/filein.m');
    if fh ~= -1
        !rm ~/.mlcom/started
        fclose(fh);
        warning off MATLAB:dispatcher:nameConflict;
        rehash path;
        run('~/.mlcom/filein.m');
        warning on MATLAB:dispatcher:nameConflict;
        !touch ~/.mlcom/done;
        !touch ~/.mlcom/started;
        !mv ~/.mlcom/filein.m ~/.mlcom/old.filein.m
    end
    pause(.1);
end
