clear
%DEFINE INITIAL VALUES AND VECTORS TO HOLD RESULTS
r0 = 30;%Hz
r_max = 50;
angle =180;%reaching angle[0 45 90 135 180 225 270 315 ]
angle_max = 180;
fr = r0+(r_max-r0)*cos(angle-angle_max);

[spikeMat, tVec] = poissonSpikeGen(fr, 1, 5);
plotRaster(spikeMat, tVec*1000);
xlabel('Time (ms)');
ylabel('Trial Number');
title('reaching angles = 315');

counts = countSpikes(spikeMat, 0.005, 0, 1);

function [spikeMat, tVec] = poissonSpikeGen(fr, tSim, nTrials)
dt = 0.001; % ms
nBins = floor(tSim/dt);
spikeMat = rand(nTrials, nBins) < fr*dt;
tVec = 0:dt:tSim-dt;
end

function [] = plotRaster(spikeMat, tVec)
hold all;
for trialCount = 1:size(spikeMat,1)
    spikePos = tVec(spikeMat(trialCount, :));
    for spikeCount = 1:length(spikePos)
        plot([spikePos(spikeCount) spikePos(spikeCount)], ...
[trialCount-0.4 trialCount+0.4], 'k');
    end
end
ylim([0 size(spikeMat, 1)+1]);
end

function counts = countSpikes(spikes, timeStepS, startS, endS)

if (nargin < 4)
    endS = length(spikes) * timeStepS;
end
if (nargin < 3)
    startS = 0;
end
trains = size(spikes, 1);
counts = zeros(1, trains);
startBin = startS / timeStepS + 1;
endBin = endS / timeStepS;

for train = 1:trains
    counts(train) = sum(spikes(train, startBin:endBin));
end
end
