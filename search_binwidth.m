clear
%DEFINE INITIAL VALUES AND VECTORS TO HOLD RESULTS
r0 = 30;%Hz[30 10]
r_max = 50;%Hz[50 80]
angle_max = 180;%[180 45]
dt = 1/1000;% time step
t_end = 10;% duraiton of the time
nTrials = 5;% the number of the train
t_vect = 0:dt:t_end-dt;  %will hold vector of times 
angle_vect = zeros(1,length(t_vect));
fr_vect = zeros(1,length(t_vect));
spiketrain_vect = zeros(nTrials,length(t_vect));
nTrials_vect = 1:1:5;
Vt = rand(nTrials,length(t_vect));
for n = nTrials_vect
    i=1;% index denoting which element of angle is being assigned 
    for t = t_vect
        angle_vect(i)= sin((t*180)/3);% one trial 
        %angle_vect(i)= sin(3*180*t);% another trial
        fr_vect(i) =  r0+(r_max-r0)*cos(angle_vect(i)-angle_max);
        if ((fr_vect(i)*dt)>Vt(n,i))
            spiketrain_vect(n,i)=1;
        else
            spiketrain_vect(n,i)=0;
        end
        i = i+1;
    end

        
end
figure(1);
subplot(5,1,1);
%sin(pie*t/3)
%sin(3pie*t)
plot(spiketrain_vect(1,:));
title('spike trains(sin(3*pie*t)) neuron B');
ylabel('train1');

subplot(5,1,2);
plot(spiketrain_vect(2,:));
ylabel('train2');

subplot(5,1,3);
plot(spiketrain_vect(3,:));
ylabel('train3');

subplot(5,1,4);
plot(spiketrain_vect(4,:));
ylabel('train4');

subplot(5,1,5);

plot(spiketrain_vect(5,:));
xlabel('Time (ms)');
ylabel('train5');

Cn = zeros(1,11);%choose 11 different width
j = 1;
for n_bins = [10000 2000 1000 500 400 250 200 100 80 40 20 ] % the number of the bins
    durationS = 10;%the time of duration
    timeStepS = durationS/n_bins; %width
    count_vect = zeros(1,n_bins);
    n=1;
    count_vect(n) = sum(countSpikes(spiketrain_vect, 0.001, 0, timeStepS));
    for num = timeStepS:timeStepS:durationS-timeStepS
        count = countSpikes(spiketrain_vect, 0.001, timeStepS*n, timeStepS*(n+1));
        count_vect(n+1)=sum(count);
        n = n +1;
    end
    m = mean(count_vect);% compute the mean
    v= var(count_vect);% compute the variance
    Cn(j) = (2*m-v)/((5*timeStepS)^2);% compute the cost function
    j=j+1;
end
figure(2);
plot(Cn);
title('Cn (sin(pie*t/3) neuron B');
xlabel('range of the bin width');
ylabel('Cn');



function counts = countSpikes(spikes, timeStepS, startS, endS)

if (nargin < 4)
    endS = length(spikes) * timeStepS;
end
if (nargin < 3)
    startS = 0;
end
trains = size(spikes, 1);
counts = zeros(1, trains);
startBin = floor(startS / timeStepS) + 1;
endBin = floor(endS / timeStepS);

for train = 1:trains
    counts(train) = sum(spikes(train, startBin:endBin));
end
end













