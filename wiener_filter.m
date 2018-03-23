
clear
load('training3.mat')
load('test3.mat')
start_time = training.StartTime;
trial_cells = training.TrialCells;
stim_type = training.StimName;
timeStepS = 0.001;
durationS = 3;
bin_width = 0.02;%200ms
n_bins = 20;

times = 0:timeStepS:durationS;	% a vector with each time step
a = trial_cells{1,1}; % the spike times of every cells

    
%c = [trial_cells{1,1}',trial_cells{1,2}'];
b = start_time(1)*1000 + a; % the relative start time
spiketime = round((b-b(1))); % normalize the spike time between 0 and 2s
spiketrain = zeros(1, length(times));
spiketrain(1)=1; % there was a spike when time equal to 0, because we normalize the spike time.
i = 2;
j = 2;
for t = 0.002:timeStepS:durationS-timeStepS % the realative time 
    if (i==spiketime(j))
        spiketrain(i)=1;
        j = j+1;   
    else
        spiketrain(i)=0;
    end
    i = i+1;
    if(j>size(spiketime))
        break;
    end
end
plot(spiketrain);
%xlim([0,2000]);
xlabel('Time (ms)');
title('spiketrain of the first cell');
timeStepS = durationS/n_bins; %width
count_vect = zeros(1,n_bins);
n=1;
count_vect(n) = sum(countSpikes(spiketrain, 0.001, 0, timeStepS));
for num = timeStepS:timeStepS:durationS-timeStepS
    count = countSpikes(spiketrain, 0.001, timeStepS*n, timeStepS*(n+1));
    count_vect(n+1)=sum(count);
    n = n +1;
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

