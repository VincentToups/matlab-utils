function [alphasynname,smartstimname,netconname,hoc__]=alpha_synapse(varargin)
% [ALPHASYNNAME,SMARTSTIMNAME,NETCONNAME,HOC__]=ALPHA_SYNAPSE(VARARGIN)
%  creates a new alpha synapse 
%  accepts either name/value pairs or a struct in the first position and then name/value pairs
%  with these values
%     defaults.section_name = 'soma';
%     defaults.location = .5;
%     defaults.e = 0;
%     defaults.tau = 3;
%     defaults.w = 1;
%     defaults.spiketimes = [];

global hoc__

[str,alphasynname,smartstimname,netconname] = ...
    create_alpha_synapse(varargin{:});

hoc__ = [hoc__ newline str newline];

