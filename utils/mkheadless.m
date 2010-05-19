function mkheadless(name)

if ~exist('name')
    name = '';
end

p = pwd;
cd ~/
str = sprintf('!screen -t "%s" matlab -nodisplay',name);
disp(str);
eval(str);
cd(p);

