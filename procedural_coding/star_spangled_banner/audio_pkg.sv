package audio_pkg;

parameter int fs = 12500 ;// sampling rate or samples/sec
parameter bits_per_samp = 8 ; //currently supports only 8 bits per sample, other applicable value is 16
parameter channels = 1 ; //only one channel supported

int unsigned filesize=10000;//aribitrary initial value, to be overwritten later
byte unsigned fsizebytes[4];


task write_wave_header ( string filename );
	int fid;
	fid =$fopen(filename,"w");
	$fwrite(fid,"RIFF");
	$fclose(fid);
	fid =$fopen(filename,"ab");
	set_file_bytes;
	$fwrite(fid,"%c",fsizebytes[0]);
	$fwrite(fid,"%c",fsizebytes[1]);
	$fwrite(fid,"%c",fsizebytes[2]);
	$fwrite(fid,"%c",fsizebytes[3]);
	$fwrite(fid,"WAVEfmt ");
	// $fwrite(fid,"");
	// $fwrite(fid,"");
	//$fwrite(fid,"%c",10);
	//$fwrite(fid,"WAVEfmt");
	$fclose(fid);
endtask // write_wave_header

task set_file_bytes;
   int unsigned tmp;
   tmp=filesize;
   fsizebytes[0]=tmp%256; tmp=tmp>>8;
   fsizebytes[1]=tmp%256; tmp=tmp>>8;
   fsizebytes[2]=tmp%256; tmp=tmp>>8;
   fsizebytes[3]=tmp%256; tmp=tmp>>8;
endtask

task write_wave_data;
endtask

endpackage