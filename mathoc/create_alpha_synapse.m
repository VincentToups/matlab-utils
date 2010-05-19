function [str,alphasynname,smartstimname,netconname] = create_alpha_synapse(stru,varargin)
%
%

if ~exist('stru')
  stru = struct;
end

defaults.section_name = 'soma';
defaults.location = .5;
defaults.e = 0;
defaults.tau = 3;
defaults.w = 1;
defaults.spiketimes = [];

if strcmp(class(stru),'char')
  varargin = [ {stru} varargin ];
  stru = struct;
end

stru = merge_structs(defaults,stru, varargs_to_struct(varargin))
unpack stru
% location                                
% section_name

alphasynname = new_unique_obj_name;

str = [...
       sprintf('objref %s', alphasynname) newline...
       sprintf('%s { ',section_name) ...
       sprintf('%s = new ExpSyn(%f) }',alphasynname,location) newline...
       sprintf('%s.tau = %f',alphasynname,tau) newline...
       sprintf('%s.e = %f',alphasynname,e) newline];

smartstimname = new_unique_obj_name;
str = [str sprintf('objref %s', smartstimname) newline...
       sprintf('%s = new SmartStim()',smartstimname) newline];

netconname = new_unique_obj_name;
str = [str sprintf('objref %s', netconname) newline...
       sprintf('%s = new NetCon(%s,%s)',netconname,smartstimname,alphasynname) newline...
       sprintf('%s.weight = %d', netconname,w) newline];

str = [str sprintf('%s.ntimes = 0',smartstimname) newline];
for i=1:length(spiketimes)
  str = [str sprintf('%s.onset[%s.ntimes] = %f',smartstimname,smartstimname,spiketimes(i)) newline];
  str = [str sprintf('%s.ntimes = %s.ntimes + 1',smartstimname,smartstimname) newline];
end
