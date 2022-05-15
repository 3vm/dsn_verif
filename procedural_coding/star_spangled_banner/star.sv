//SystemVerilog Program to syzthesize the music of Star spangled banner song

import audio_pkg::*;
import carnatic_pkg::*;
import thee_mathsci_consts_pkg::const_pi;

parameter string song_wave_file="USA-anthem-SV.wav";
parameter int n = t*fs ;// number of samples in one duration

//Windows to get the effect of note stopping, playing continously, starting, starting and stopping in the same duration
parameter int WN = 120; //window length in samples

int fid_rd, fid_wr;

real wnone[n]      = '{default:1.0};
real wascending[n] = '{default:1.0};
real wfalling[n]   = '{default:1.0};
real wboth[n]      = '{default:1.0};
real w[n]          = '{default:1.0};
real scaling=0.9;//avoid full scale
string this_str,swara,window;
int code;
real freq,dat;
real theta, delta_theta;
int bytes;
byte sample_value;

initial begin
  create_swara_freq_table();
  show_swaras;
  write_wave_header(song_wave_file);
  open_wave_for_data(song_wave_file,fid_wr);

  for (int i=0;i<WN;i++) begin
    wnone[i]=1.0;
    wascending[i]=i/WN;
    wboth[i]=wascending[i];
  end
  
  for (int i=WN-1;i>=0;i--) begin
    wfalling[i]=(WN-i)/WN;
    wboth[i]=wfalling[i];
  end

  fid_rd=$fopen("star-spangled-banner-carnatic.txt","r");
  code=$fgets(this_str,fid_rd); //comment line

  theta=0;
  delta_theta=0;
  while($fscanf(fid_rd,"%s",this_str)!=-1) begin
    $display(this_str);
    if (this_str[1]==",") begin
      swara = this_str.substr(0,0);
      window = this_str.substr(2,2);
    end else begin
      swara = this_str.substr(0,1);
      window = this_str.substr(3,3);
    end      
    $display("This swara is %s with window %s",swara,window);

    freq = swara_freq[swara];
    delta_theta = 2*const_pi*freq/fs;
    // for every note in the song play a single tone of the frequency obtained from the note name to frequency lookup table
    // Also include the appropriate start, stop, continuous play effects done using amplitude windows.  
    if (window == "0") begin
      w = wnone;
    end else if (window == "a") begin
      w = wascending;
    end else if (window == "f") begin
      w = wfalling;
    end else if (window == "b") begin
      w = wboth;
    end

    // phase of the sine wave from previous note to this note should be continuous to avoid hearing clicks between notes
    for(int i=0, bytes=0;i<n;i++,bytes++) begin
      dat = scaling*$sin(theta)*w[i]; //suspect formula - attempting to get continuous phase
      theta += delta_theta;
      theta = (theta > 2*pi) ? 2*pi -theta : theta;
      $cast (sample_value , (2**15) * dat);
      $display("Sample value real %1.2f char %4d",dat,sample_value);
      write_wave_data16b(fid_wr, sample_value);
    end
  
  end
  $fclose(fid_rd);

  $fclose(fid_wr);
  
  //update_wave_header (song_wave_file, bytes);

end