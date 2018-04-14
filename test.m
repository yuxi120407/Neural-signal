clear
[w_train,Fs_train] = audioread('train_signal.wav');
[w_test,Fs_test] = audioread('test_signal.wav');
[w_noise,Fs_noise] = audioread('noise_signal.wav');

train_signal = timetable(seconds((0:length(w_train)-1)'/Fs_train),w_train);
noise_signal = timetable(seconds((0:length(w_noise)-1)'/Fs_noise),w_noise);
test_signal = timetable(seconds((0:length(w_test)-1)'/Fs_test),w_test);