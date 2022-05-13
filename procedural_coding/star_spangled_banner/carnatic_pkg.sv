package carnatic_pkg;

// Notes table - contains the names of the music notes derived from Carnatic music tradition, though not exactly same
//dc is 0 frequency, sl to nh have geometrically increasing frequencies. frequency of rl is 1.1 times that of sl and gl is 1.1*rl and so on..
string notes[] = '{"dc","sl","rl","gl","ml","pl","dl","nl",
          "s","r","g","m","p","d","n",
          "sh","rh","gh","mh","ph","dh","nh"};
/*
freq = c(0, 320 * 1.1 ^ c ( 0 : 20 ) )
//a look up table for a note name and its frequency
raga = data.frame ( freq, row.names = notes )
*/
endpackage