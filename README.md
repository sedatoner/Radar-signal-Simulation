# Radar Signal Simulation

This is a simple radar signal simulation I built in MATLAB, mostly to understand how basic radar systems work and to have a little fun along the way.

The idea is straightforward: I generate a linear chirp signal, add some Gaussian noise, simulate an echo from a target, clean things up using a bandpass filter, and finally try to detect the signal using matched filtering. I also take a look at the frequency spectrum of the chirp to see what it's made of.

## What I Do in This Project

- Generate a linear chirp (frequency increases over time)
- Add white Gaussian noise manually (no toolbox needed)
- Simulate an echo from a target (delayed and weaker chirp)
- Apply a bandpass filter to clean the noisy signal
- Use matched filtering to detect the signal and its echo
- Visualize the frequency spectrum using FFT

## Why I Did This

I wanted to get a hands-on feel for how radar signal processing works. This is not a full radar system, of course but it’s a great way to see the concepts in action:
- How noise affects a signal
- How we can reduce that noise
- How matched filters can "find" our signal again
- How target echoes appear and can be detected

Also, it reminded me of communication theory topics like modulation and demodulation, which made it even more interesting.


## How It Works

1. **Chirp Generation**  
   I create a signal that starts at 500 Hz and ramps up to 3000 Hz over 10 milliseconds.

2. **Echo Simulation**  
   I insert a delayed and attenuated version of the chirp to simulate a target reflection (like something bounced it back).

3. **Noise Addition**  
   Gaussian noise is manually calculated and added to the received signal.

4. **Filtering**  
   A 4th-order Butterworth bandpass filter keeps only the frequencies between 400 and 3500 Hz.

5. **Matched Filtering**  
   I flip the original chirp and convolve it with the noisy signal to detect both the direct signal and the echo.

6. **FFT Analysis**  
   I run an FFT on the original chirp to see how its frequency content is spread out.

## What You’ll See

- Plots of the clean chirp, noisy signal, filtered signal
- Matched filter output showing peaks (one for the original chirp, one for the echo)
- Frequency spectrum of the chirp

## Can You Expand It?

Absolutely:
- Try different SNR values
- Add multiple echoes with different delays
- Make the chirp sweep down instead of up
- Build a GUI with sliders for noise, delay, and attenuation

## Final Thoughts

This started out as a small test script and turned into a pretty decent little radar sim. It helped me understand some important ideas in signal processing and radar, and honestly it’s just fun watching the matched filter find those echoes.

Feel free to fork, modify, or just explore the code.
