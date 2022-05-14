package carnatic_pkg;

parameter real t = 0.3 ;//duration to play a note in seconds

// Notes table - contains the names of the music notes derived from Carnatic music tradition, though not exactly same
//dc is 0 frequency, sl to nh have geometrically increasing frequencies. frequency of rl is 1.1 times that of sl and gl is 1.1*rl and so on..
string swaras[] = '{"sl","rl","gl","ml","pl","dl","nl",
          "s","r","g","m","p","d","n",
          "sh","rh","gh","mh","ph","dh","nh"};
parameter real sl_freq = 320 ; //assuming 320Hz frequence for Sa lower swara

real swara_freq [ string ];

function void create_swara_freq_table;
  foreach ( swaras[i] ) begin
    swara_freq[swaras[i]] = 320 * (1.104089514 ** i);
  end
endfunction

task show_swaras;
    foreach (swaras[i]) begin
        $display("Swara %s has frequency %4.2f",swaras[i], swara_freq[swaras[i]]);
    end
endtask

endpackage