%% Radar Signal Simulation in MATLAB (with echo)
clc; clear; close all;

%% First, I set up the basic parameters
fs = 1e4;          % I'm sampling at 10,000 Hz
T = 1e-2;          % My signal lasts 10 milliseconds
t = 0:1/fs:T;      % Here's my time axis

f0 = 500;          % The chirp starts at 500 Hz
f1 = 3000;         % And it goes up to 3000 Hz

%% Now I generate the chirp signal
chirp_signal = chirp(t, f0, T, f1);  % Linear chirp signal

figure;
plot(t, chirp_signal);
xlabel('Time (s)');
ylabel('Amplitude');
title('Chirp Signal (clean and simple)');
grid on;

%% I simulate a simple echo (like a target reflecting the signal)
delay_samples = round(0.002 * fs);   % Echo comes back after 2 milliseconds
attenuation = 0.5;                   % Echo is weaker than original
echo = [zeros(1, delay_samples), attenuation * chirp_signal(1:end-delay_samples)];

% I combine the original signal and the echo
received_signal = chirp_signal + echo;

%% I add Gaussian noise manually (since I don't use the toolbox)
snr_db = 0;  % 0 dB SNR = signal and noise are equal in power
signal_power = rms(received_signal)^2;
snr_linear = 10^(snr_db/10);
noise_power = signal_power / snr_linear;
noise = sqrt(noise_power) * randn(size(received_signal));
noisy_received = received_signal + noise;

figure;
plot(t, noisy_received);
xlabel('Time (s)');
ylabel('Amplitude');
title('Received Signal with Echo and Noise');
grid on;

%% I apply a bandpass filter to reduce noise
f_low = 400; 
f_high = 3500;
[b, a] = butter(4, [f_low f_high]/(fs/2), 'bandpass');
filtered_signal = filter(b, a, noisy_received);

figure;
plot(t, filtered_signal);
xlabel('Time (s)');
ylabel('Amplitude');
title('Filtered Received Signal');
grid on;

%% Now I try to detect the original signal using matched filtering
mf = fliplr(chirp_signal);                     % Time-reversed chirp
matched_output = conv(noisy_received, mf, 'same');  % Correlation-like detection

figure;
plot(matched_output);
xlabel('Samples');
ylabel('Matched Output');
title('Matched Filter Response (with Echo)');
grid on;

%% I also check out the frequency content of the original chirp
N = length(chirp_signal);
f = linspace(0, fs, N);
chirp_fft = abs(fft(chirp_signal));

figure;
plot(f, chirp_fft);
xlim([0 fs/2]);
xlabel('Frequency (Hz)');
ylabel('Magnitude');
title('Chirp Signal Frequency Spectrum');
grid on;

% This frequency plot shows how the chirp spreads across a wide range,
% starting from 500 Hz and ending around 3000 Hz  just as I intended.
