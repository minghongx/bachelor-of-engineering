%% Part A question 2

close all

tiledlayout(2,2);

nexttile;
fplot(fourier_series_of_a_square_wave(0, 1, 100, 5), [-.05, .05]);
title("5 hamonics synthesised");

nexttile;
fplot(fourier_series_of_a_square_wave(0, 1, 100, 10), [-.05, .05]);
title("10 hamonics synthesised");

nexttile;
fplot(fourier_series_of_a_square_wave(0, 1, 100, 100), [-.05, .05]);
title("100 hamonics synthesised");

nexttile;
fplot(fourier_series_of_a_square_wave(0, 1, 100, 1000), [-.05, .05]);
title("1000 hamonics synthesised");

function series = fourier_series_of_a_square_wave(dc, maximun_applicable_voltage, fundemental_angular_freqency, num_of_hamonics)
    arguments
        dc {mustBeNumeric, mustBeReal, mustBeFinite}
        maximun_applicable_voltage {mustBeNumeric, mustBeReal, mustBeFinite}
        fundemental_angular_freqency {mustBeNumeric, mustBeReal, mustBeFinite}
        num_of_hamonics {mustBeInteger, mustBePositive}
    end

    fourier_series = @(t) dc;
    for nth = 1 : num_of_hamonics
        n = 2 * nth - 1;
        hamonic = @(t) maximun_applicable_voltage * rdivide(1,n) * sin(n*fundemental_angular_freqency*t);
        fourier_series = @(t) fourier_series(t) + hamonic(t);
    end
    series = fourier_series;
end
