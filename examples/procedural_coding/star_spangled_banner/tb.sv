
program tb ;

import carnatic_pkg :: * ;

parameter string song_carnatic_file = "star-spangled-banner-carnatic.txt" ;
 // parameter string song_carnatic = "debug-song.txt" ;
parameter string song_wav_file = "USA-anthem-SV.wav" ;

initial begin
   create_swara_freq_table ( ) ;
   show_swaras ( ) ;
   init_swara_windows ( ) ;
   parse_song_carnatic ( song_carnatic_file ) ;
   export_song_wav ( song_wav_file ) ;
   $finish ;
end

logic vikram ;
endprogram
