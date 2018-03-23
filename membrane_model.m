clear
timeStepS = 0.001; % 1ms
durationS = 1000; % 1 sec simulation
times = 0:timeStepS:durationS;	% a vector with each time step
Vt = rand(1, length(times));
spiketrain = zeros(1, length(times));
tau_vect = 20:1:39;
fano = zeros(1, length(tau_vect));
CV = zeros(1, length(tau_vect));
PlotNum=0;
for tau = tau_vect

    PlotNum = PlotNum + 1;
    fr_vect = zeros(1, length(times));
    fr_inf = 50;
    i = 1;
    fr_vect(i) = fr_inf; % intially r(t)=50Hz
    for t = 0:timeStepS:durationS

        if (fr_vect(i)*timeStepS>Vt(i))
            fr_vect(i+1) = 0; % after every spike set r(t)=0
            spiketrain(i) = 1; % generate a poisson spike train
        else
            fr_vect(i+1) = fr_inf + (fr_vect(i) - fr_inf)*exp(-1/tau);% iterate firing rate depend on time
            spiketrain(i) = 0;
        end
        i = i+1;    

    end 
    figure(1);
    plot(fr_vect);
    xlabel('Time (s)')
    ylabel('firing rate (Hz)')
    title('firing rate depend on time');

    figure(2);
    plot(spiketrain);
    xlabel('Time (s)')
    title('Raster plot of spikes(refractory period)');

    spikeTimes = find(spiketrain) * timeStepS * 1000; % get times when spikes occurred (ms)
    fano(PlotNum) = var(spikeTimes) / mean(spikeTimes);% computer Fano factor
    spikeIntervals = spikeTimes(2:length(spikeTimes)) - spikeTimes(1:length(spikeTimes) - 1);
    CV(PlotNum) = std(spikeIntervals) / mean(spikeIntervals);% computer coefficient of variation
    binSize = 1;                                            % 1 ms bins
    x = 1:binSize:100;
    intervalDist = hist(spikeIntervals(spikeIntervals < 100), x);
    intervalDist = intervalDist / sum(intervalDist) / binSize; % normalize by dividing by spike number
    figure(3);
    subplot(5,4,PlotNum)
    bar(x, intervalDist);
    if (PlotNum == 1)
    title('tau=1ms');
    end
    if (PlotNum == 2)
    title('tau=2ms');
    end
    if (PlotNum == 3)
    title('tau=3ms');
    end
    if (PlotNum == 4)
    title('tau=4ms');
    end
    if (PlotNum == 5)
    title('tau=5ms');
    end
    if (PlotNum == 6)
    title('tau=6ms');
    end
    if (PlotNum == 7)
    title('tau=7ms');
    end
    if (PlotNum == 8)
    title('tau=8ms');
    end
    if (PlotNum == 9)
    title('tau=9ms');
    end
    if (PlotNum == 10)
    title('tau=10ms');
    end
    if (PlotNum == 11)
    title('tau=11ms');
    end
    if (PlotNum == 12)
    title('tau=12ms');
    end
    if (PlotNum == 13)
    title('tau=13ms');
    end
    if (PlotNum == 14)
    title('tau=14ms');
    end
    if (PlotNum == 15)
    title('tau=15ms');
    end
    if (PlotNum == 16)
    title('tau=16ms');
    end
    if (PlotNum == 17)
    title('tau=17ms');
    end
    if (PlotNum == 18)
    title('tau=18ms');
    end
    if (PlotNum == 19)
    title('tau=19ms');
    end
    if (PlotNum == 20)
    title('tau=20ms');
    end


end
figure(4);
plot(CV,'ro');
xlabel('tau_{ref}(s)')
ylabel('coefficient of variation')
title('coefficient of variation with different refractory recovery rate');
figure(5);
plot(fano,'bo');
xlabel('tau_{ref}(s)')
ylabel('Fano factor')
title('Fano factor with different refractory recovery rate');
