function debugdisp(thing)
% DEBUGDISP like disp but only functions when debug is on

ptdebug
if(PT_DEBUG)
    disp(thing);
end

