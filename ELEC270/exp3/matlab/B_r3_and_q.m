%% Part B

%%
close all

V = 2;
fundemental_angular_freqency = 100;
T = rdivide(2*pi, fundemental_angular_freqency);

%% requirement 3
synthesised_10 = fourier_series_of_a_sawtooth_wave(V, fundemental_angular_freqency, 10);
fplot(synthesised_10, [-T, T]);

%% question 1
subplot(2,1,1), fplot(synthesised_10, [0, T]), title("10 hamonics synthesised sawtooth waveform");
original = @(t) V - rdivide(2*V,T) * t;
subplot(2,1,2), fplot(original, [0, T]), title("original sawtooth waveform");

%% question 2
synthesised_5 = fourier_series_of_a_sawtooth_wave(V, fundemental_angular_freqency, 5);
subplot(2,1,2), fplot(synthesised_5, [0, T]), title("5 hamonics synthesised sawtooth waveform");

%% fourier series factory
function series = fourier_series_of_a_sawtooth_wave(V, fundemental_angular_freqency, num_of_hamonics)
    arguments
        V {mustBeNumeric, mustBeReal, mustBeFinite}
        fundemental_angular_freqency {mustBeNumeric, mustBeReal, mustBeFinite}
        num_of_hamonics {mustBeInteger, mustBePositive}
    end

    fourier_series = @(t) 0;
    for n = 1 : num_of_hamonics
        hamonic = @(t) rdivide(2*V,pi*n) * sin(n*fundemental_angular_freqency*t);
        fourier_series = @(t) fourier_series(t) + hamonic(t);
    end
    series = fourier_series;
end
