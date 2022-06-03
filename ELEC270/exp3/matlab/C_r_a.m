%% Part C reqiurement a

close all

f1 = fourier_series_of_f1(100, 100);
fplot(f1, [-.05, .05])


function series = fourier_series_of_f1(fundemental_angular_freqency, num_of_hamonics)
    arguments
        fundemental_angular_freqency {mustBeNumeric, mustBeReal, mustBeFinite}
        num_of_hamonics {mustBeInteger, mustBePositive}
    end

    fourier_series = @(t) 0;
    for nth = 1 : num_of_hamonics
        n = 2 * nth - 1;
        hamonic = @(t) power(-1,nth-1) * rdivide(1,n^2) * sin(n*fundemental_angular_freqency*t);
        fourier_series = @(t) fourier_series(t) + hamonic(t);
    end
    series = fourier_series;
end
