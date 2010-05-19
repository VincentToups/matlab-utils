function voltage_plot(voltage_traces) 
%
%
%


ss = 2*mean(std(voltage_traces,[],2),1);
ss = repmat(  (((1:size(voltage_traces,1))-1)*ss)', [1 ...
                    size(voltage_traces,2)]);
voltage_traces = voltage_traces + ss;
plot(voltage_traces');

