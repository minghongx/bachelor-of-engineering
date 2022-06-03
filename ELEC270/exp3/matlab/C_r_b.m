%% Part C reqiurement b

close all

f2 = fourier_series_of_f2(100, 100);
fplot(f2, [-.05, .05])


function series = fourier_series_of_f2(fundemental_angular_freqency, num_of_hamonics)
    arguments
        fundemental_angular_freqency {mustBeNumeric, mustBeReal, mustBeFinite}
        num_of_hamonics {mustBeInteger, mustBePositive}
    end

    fourier_series = @(t) 0;
    for n = 1 : num_of_hamonics
        hamonic = @(t) 0.1 * cos(n*fundemental_angular_freqency*t);
        fourier_series = @(t) fourier_series(t) + hamonic(t);
    end
    series = fourier_series;
end
