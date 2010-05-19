

(progn 
  (insert "\nspikes = []\n") 
  (loop for x from 1 to 11 do
    (insert (format "load relitrial_%d; spikes = sloppycat(spikes,relitrial_%d,1)\n" x x))))

spikes = []


load phase_test_3_1; spikes = sloppycat(spikes,phase_test_3_1,1)
load phase_test_3_2; spikes = sloppycat(spikes,phase_test_3_2,1)
load phase_test_3_3; spikes = sloppycat(spikes,phase_test_3_3,1)
load phase_test_3_4; spikes = sloppycat(spikes,phase_test_3_4,1)
load phase_test_3_5; spikes = sloppycat(spikes,phase_test_3_5,1)
load phase_test_3_6; spikes = sloppycat(spikes,phase_test_3_6,1)
load phase_test_3_7; spikes = sloppycat(spikes,phase_test_3_7,1)
load phase_test_3_8; spikes = sloppycat(spikes,phase_test_3_8,1)
load phase_test_3_9; spikes = sloppycat(spikes,phase_test_3_9,1)
load phase_test_3_10; spikes = sloppycat(spikes,phase_test_3_10,1)
load phase_test_3_11; spikes = sloppycat(spikes,phase_test_3_11,1)

load example_output

subplot(2,1,1);
rast(example_output)
subplot(2,1,2);
rast(spikes);

ds = dataset(ds,'phase_test_3')
dssave(ds)

;%%% 
