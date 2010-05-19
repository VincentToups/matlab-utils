function res=sections_re(re)
global sections__
res = sections__(find(regexpcmp(re,sections__)));
