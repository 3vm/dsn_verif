#R Language script to synthesize one single tone


# install.packages('audio') -- install this package if you don't already have it
library(audio)

t = 5 #duration to play a note in seconds
fs = 12500 # sampling rate or samples/sec
n = t*fs # number of samples in one duration

music = c(NULL)

sin_factor = 2*pi/fs

  thissteps = c(1:n);
  freq = 1250
  tone = sin(sin_factor*thissteps*freq)  
  music = c(music, tone)

#Convert to audio format          
audio = audioSample(music, fs,bits=8)
save.wave(audio, "tone_8b.wav")
