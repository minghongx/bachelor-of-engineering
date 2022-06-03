%% Part E reqiurement 2

%%
close all

sampling_frequency = 44100;
duration = 3;
t = 0:rdivide(1,sampling_frequency):duration;
amplitude = 10;
f_0 = 500;

%%
hamonic_1 = amplitude * sin(2*pi*f_0*t);
sound(hamonic_1, sampling_frequency);

%%
hamonic_2 = amplitude * sin(2*pi*2*f_0*t);
sound(hamonic_2, sampling_frequency);

%%
hamonic_3 = amplitude * sin(2*pi*3*f_0*t + pi/2);
sound(hamonic_3, sampling_frequency);

%%
chord = hamonic_1 + hamonic_2 + hamonic_3;
sound(chord, sampling_frequency);

%%
plot(chord);
xlim([0 180]);
