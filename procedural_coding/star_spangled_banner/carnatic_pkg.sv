package carnatic_pkg ;

import thee_audio_pkg :: * ;
import thee_mathsci_consts_pkg :: const_pi ;

parameter real t = 0.3 ; // duration to play a note in seconds

 // Notes table - contains the names of the music notes derived from Carnatic music tradition , though not exactly same
 // dc is 0 frequency , sl to nh have geometrically increasing frequencies. frequency of rl is 1.1 times that of sl and gl is 1.1 * rl and so on..
string swaras [ ] = '{ "sl" , "rl" , "gl" , "ml" , "pl" , "dl" , "nl" ,
 "s" , "r" , "g" , "m" , "p" , "d" , "n" ,
 "sh" , "rh" , "gh" , "mh" , "ph" , "dh" , "nh" } ;
parameter real sl_freq = 320 ; // assuming 320Hz frequence for Sa lower swara

int window_index_table [ string ] ;

real swara_freq [ string ] ;

 // Exercise create your own set of notes and their frequencies if you need
 /*
real swara_freq [ string ] =
initialize array values
sl 342.2
rl 431.9
...
or
C# 423
D# 553
...
 */

function void create_swara_freq_table ;
   foreach ( swaras [ i ] ) begin
     swara_freq [ swaras [ i ] ] = 320 * ( 1.104089514 ** i ) ;
   end
endfunction

 task show_swaras ;
   foreach ( swaras [ i ] ) begin
     $display ( "Swara %s has frequency %4.2f Hz" , swaras [ i ] , swara_freq [ swaras [ i ] ] ) ;
   end
 endtask

parameter int n = t * fs ; // number of samples in one duration

 // Windows to get the effect of note stopping , playing continously , starting , starting and stopping in the same duration
parameter int WN = 120 ; // window length in samples

int fid_rd , fid_wr ;

real wnone [ n ] = '{ default : 1.0 } ;
real wascending [ n ] = '{ default : 1.0 } ;
real wfalling [ n ] = '{ default : 1.0 } ;
real wboth [ n ] = '{ default : 1.0 } ;
real wall [4][ n ] ;

real scaling = 0.9 ; // avoid full scale
int code ;
real freq , dat ;
real theta , delta_theta ;
int bytes ;
shortint sample_value ;

typedef struct {
  real freq;
  bit [1:0] window_index; //code 0- no window, 1-ascending window, 2-falling, 3-ascending and falling
} carnatic_swara_t ;

carnatic_swara_t swaras_n_windows[];

task init_swara_windows ;
   for ( int i = 0 ; i < WN ; i ++ ) begin
     wnone [ i ] = 1.0 ;
     wascending [ i ] = 1.0 * i / WN ;
     wboth [ i ] = 1.0 * wascending [ i ] ;
   end
  
   for ( int i = n-1 , int j = 0 ; i >= n-WN-1 ; i-- , j ++ ) begin
     wfalling [ i ] = 1.0 * j / WN ;
     wboth [ i ] = 1.0 * wfalling [ i ] ;
   end
   wall[0] = wnone;
   wall[1] = wascending;
   wall[2] = wfalling;
   wall[3] = wboth;

   window_index_table ["0"] = 0;
   window_index_table ["a"] = 1;
   window_index_table ["f"] = 2;
   window_index_table ["b"] = 3;
endtask

task parse_song_carnatic ( string song_carnatic_file ) ;
   string this_str , swara , window_str ;
   int i;
   fid_rd = $fopen ( song_carnatic_file , "r" ) ;
   code = $fgets ( this_str , fid_rd ) ; // comment line

   i=0;
   while ( $fscanf ( fid_rd , "%s" , this_str ) != -1 ) begin
     if ( this_str [ 1 ] == " , " ) begin
       swara = this_str.substr ( 0 , 0 ) ;
       window_str = this_str.substr ( 2 , 2 ) ;
     end else begin
       swara = this_str.substr ( 0 , 1 ) ;
       window_str = this_str.substr ( 3 , 3 ) ;
     end
     $display ( "This swara is %s with window %s" , swara , window_str ) ;
     swaras_n_windows[i].freq = swara_freq [ swara ] ;
     swaras_n_windows[i].window_index = window_index_table[window_str];
     i++;
   end
   $fclose ( fid_wr ) ;
endtask

task export_song_wav ( string song_wav_file ) ;
   write_wav_header ( song_wav_file ) ;
   open_wav_for_data ( song_wav_file , fid_wr ) ;
  
   theta = 0 ;
   delta_theta = 0 ;

   foreach ( swaras_n_windows [ i ] ) begin    
     freq = swaras_n_windows[i].freq ;
     delta_theta = 2 * const_pi * freq / fs ;
     // for every note in the song play a single tone of the frequency obtained from the note name to frequency lookup table
     // Also include the appropriate start , stop , continuous play effects done using amplitude windows.
    
     // phase of the sine wav from previous note to this note should be continuous to avoid hearing clicks between notes
     for ( int j = 0 , bytes = 0 ; j < n ; j ++ , bytes ++ ) begin
       dat = scaling * $sin ( theta ) * wall[swaras_n_windows[i].window_index ] [ i ] ;
       theta += delta_theta ;
       theta = ( theta > 2 * const_pi ) ? 2 * const_pi -theta : theta ;
       $cast ( sample_value , ( 2 ** 15 ) * dat ) ;
       // $display ( "Sample value real %1.2f char %4d window %1.2f" , dat , sample_value , wall[swaras_n_windows[i].window_index ] [ j] ) ;
       write_wav_data16b ( fid_wr , sample_value ) ;
     end
     $display ( "Swara end" ) ;
    
   end

   $fclose ( fid_rd ) ;
  
   // update_wav_header ( song_wav_file , bytes ) ;
  
endtask

endpackage
