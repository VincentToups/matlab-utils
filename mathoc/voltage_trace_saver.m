function [hoc__,name,filename] = voltage_trace_saver(params)
% HOC__ = VOLTAGE_TRACE_SAVER(PARAMS)
global hoc__

if ~exist('params')
  params = struct;
end

[vtsstring, name, filename] = create_voltage_trace_saver(params);
hoc__ = [hoc__ newline vtsstring];


