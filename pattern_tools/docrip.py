import os
import sys

os.system('ls *.m > tmp');
f = file('tmp');
lines = f.readlines();
f.close();

o = file('documentation.txt','w');

for line in lines:
    line = line.split()[0];
    f = file(line);
    sublines = f.readlines();
    f.close();
    subline = sublines[0];
    ii = 0;
    first = True;
    
    title = ':: '+line+' ::';
    spacer = ''.join([':' for x in range(len(title))]);
    o.write(spacer+'\n');
    o.write(title+'\n');
    o.write(spacer+'\n');
    while subline[0] == '%' or first == True and ii < len(sublines):
        o.write(subline);
        print subline[0]
        print ii
        print first
        ii = ii + 1;
        subline = sublines[ii];
        first = False;
    o.write(spacer+'\n');
    o.write(title+'\n');
    o.write(spacer+'\n');

