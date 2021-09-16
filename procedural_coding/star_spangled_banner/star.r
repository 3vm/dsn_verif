#R Language script to syzthesize the music of Star spangled banner song


# install.packages('audio') -- install this package if you don't already have it
library(audio)

# Notes table - contains the names of the music notes derived from Carnatic music tradition, though not exactly same
#dc is 0 frequency, sl to nh have geometrically increasing frequencies. frequency of rl is 1.1 times that of sl and gl is 1.1*rl and so on..
notes = c("dc","sl","rl","gl","ml","pl","dl","nl",
          "s","r","g","m","p","d","n",
          "sh","rh","gh","mh","ph","dh","nh")
freq = c(0, 320 * 1.1 ^ c ( 0 : 20 ) )
#a look up table for a note name and its frequency
raga = data.frame ( freq, row.names = notes )
t = 0.3 #duration to play a note in seconds
fs = 12500 # sampling rate or samples/sec
n = t*fs # number of samples in one duration

#Windows to get the effect of note stopping, playing continously, starting, starting and stopping in the same duration

WN = 120;
wnone = c(1:n)/c(1:n)
wascending = wnone
wfalling = wnone
wboth = wnone

ascending = seq(0,1-(1/WN),length=WN)
falling = seq(1-(1/WN),0,length=WN)

wascending[1:WN] = seq(0,1-(1/WN),length=WN)
wboth[1:WN] = seq(0,1-(1/WN),length=WN)

wfalling[(n-WN+1):n] = seq(1-(1/WN),0,length=WN)
wboth[(n-WN+1):n] = seq(1-(1/WN),0,length=WN)

#notes format - <note>,<window descriptor>
#No space character between the opening quote and the first note 
song = 
"p,b   g,b   s,a   s,f   dl,a  dl,f  pl,a  pl,f  s,a   s,0   s,f  
g,a   g,f   r,b   s,a   s,f   dl,a  dl,f  m,a   m,f   p,a   p,f
p,b   p,b   gh,a  gh,0  gh,f  rh,b  sh,a  sh,0  sh,f  n,a   n,f
d,b   n,b   sh,a  sh,f  sh,a  sh,f  p,a   p,f   g,a   g,f   s,b
p,b   g,b   s,a   s,f   dl,a  dl,f  pl,a  pl,f  s,a   s,0   s,f  
g,a   g,f   r,b   s,a   s,f   dl,a  dl,f  m,a   m,f   p,a   p,f
p,b   p,b   gh,a  gh,0  gh,f  rh,b  sh,a  sh,0  sh,f  n,a   n,f
d,b   n,b   sh,a  sh,f  sh,a  sh,f  p,a   p,f   g,a   g,f   s,b
gh,a  gh,f  gh,a  gh,f  mh,a  mh,f  ph,a  ph,f  ph,a  ph,0  ph,f 
mh,b  gh,b  rh,a  rh,f  gh,a  gh,f  mh,a  mh,f  mh,a  mh,0  mh,f
mh,a  mh,f  gh,a  gh,0  gh,f  rh,b  sh,a  sh,f  n,a   n,0   n,f
d,b   n,b   sh,a  sh,f  d,a   d,f   m,a   m,f   p,a   p,0   p,f
p,b   sh,a  sh,f  sh,a  sh,f  sh,b  n,d   d,a   d,f   d,a   d,f
r,a   r,f   m,b   g,b   r,b   sh,b  sh,a  sh,0  sh,f  n,a   n,f
p,b   p,b   sh,a  sh,0  sh,f  rh,b  gh,b  mh,b  ph,a  ph,0  ph,f
sh,a  sh,f  rh,a  rh,f  gh,b  m,a   m,f   r,a   r,f   s,a   s,f
"

music = c(NULL)
snotes = strsplit(song,"\\s+")
snotes = snotes[[1]]

sin_factor = 2*pi/fs

# for every note in the song play a single tone of the frequency obtained from the note name to frequency lookup table
# Also include the appropriate start, stop, continuous play effects done using amplitude windows.  
for(i in 1:length(snotes)) {
  double = strsplit(snotes[i],",")
  thisnote = double[[1]][1]
  thisw = double[[1]][2]
  if (thisw == "0") {
    w = wnone
  } else if (thisw == "a") {
    w = wascending
  } else if (thisw == "f") {
    w = wfalling
  } else if (thisw == "b") {
    w = wboth
  }
  # phase of the sine wave from previous note to this note should be continuous to avoid hearing clicks between notes
  thissteps = c((1+n*(i-1)):(i*n));
  freq = raga[thisnote,1]
  tone = sin(sin_factor*thissteps*freq)*w
  music = c(music, tone)
}
#Convert to audio format          
audio = audioSample(music, fs)
save.wave(audio, "USA-anthem.wav")
