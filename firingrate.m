clear
fr = 50; % constant firing rate Hz
dt = 1/1000; % s
nBins = 100000; % the number of the intervel
myPoissonSpikeTrain = rand(1, nBins) < fr*dt;
figure(1);
spiketrain_long = 0:0.001:1;
plot(myPoissonSpikeTrain);
xlabel('Time (s)')
title('Raster plot of spikes');
spikeTimes = find(myPoissonSpikeTrain) * dt * 1000;
fano = var(spikeTimes) / mean(spikeTimes);
spikeIntervals = spikeTimes(2:length(spikeTimes)) - spikeTimes(1:length(spikeTimes) - 1);
CV = std(spikeIntervals) / mean(spikeIntervals);
binSize = 1;                                            % 1 ms bins
x = 1:binSize:100;
intervalDist = hist(spikeIntervals(spikeIntervals < 100), x);
intervalDist = intervalDist / sum(intervalDist) / binSize; % normalize by dividing by spike number
figure(2);
bar(x, intervalDist,'g');
title('interspike interval histogram(without refractory period)');