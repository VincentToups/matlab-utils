function res = cleave(fs,varargin)
res = map(@(f) apply(f,varargin),fs);
