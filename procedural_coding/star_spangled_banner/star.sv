//SystemVerilog Program to syzthesize the music of Star spangled banner song

import audio_pkg::*;
import carnatic_pkg::*;

parameter string song_wave_file="USA-anthem-SV.wav";
parameter int n = t*fs ;// number of samples in one duration

//Windows to get the effect of note stopping, playing continously, starting, starting and stopping in the same duration
parameter int WN = 120; //window length in samples

real wnone[n] = '{default:1};
real wascending[n] = '{default:1};
real wfalling[n] = '{default:1};
real wboth[n] = '{default:1};

initial begin
for (int i=0;i<WN;i++) begin
  wascending[i]=i/WN;
  wboth[i]=wascending[i];
end

for (int i=WN-1;i>=0;i--) begin
  wfalling[i]=(WN-i)/WN;
  wboth[i]=wfalling[i];
end
end

initial begin
  string this_str,swara,window;
  int fid;
  int code;
  create_swara_freq_table();
  show_swaras;
  write_wave_header(song_wave_file);
  fid=$fopen("star-spangled-banner-carnatic.txt","r");
  code=$fgets(this_str,fid); //comment line
  while($fscanf(fid,"%s",this_str)!=-1) begin
    $display(this_str);
    if (this_str[1]==",") begin
      swara = this_str.substr(0,0);
      window = this_str.substr(2,2);
    end else begin
      swara = this_str.substr(0,1);
      window = this_str.substr(3,3);
    end      
  

//    code = $sscanf(this_str,"%s,%s", swara, window);
    //if(swara!="" && window!="" && code!=-1 )
      $display("This swara is %s with window %s",swara,window);
    //else
      //$display("Error");
  end
  $fclose(fid);
end

/*
music = c(NULL)
snotes = strsplit(song,"\\s+")
snotes = snotes[[1]]

sin_factor = 2*pi/fs

// for every note in the song play a single tone of the frequency obtained from the note name to frequency lookup table
// Also include the appropriate start, stop, continuous play effects done using amplitude windows.  
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
//Convert to audio format          
audio = audioSample(music, fs)
save.wave(audio, "USA-anthem.wav")
*/