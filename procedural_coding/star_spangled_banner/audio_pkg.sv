package audio_pkg;

parameter int fs = 12500 ;// sampling rate or samples/sec
parameter bits_per_samp = 16 ; //currently supports only 8 bits per sample, other applicable value is 16

int unsigned file_size=10000044;//aribitrary initial value, to be overwritten later
byte unsigned fsizebytes[4];
shortint unsigned fmt_type=1; //PCM format
shortint unsigned channels=1; //mono=1/stereo=2/more.., only mono supported for now
int unsigned sampling_rate=fs;
int unsigned byte_rate=sampling_rate*bits_per_samp*channels/8;
shortint unsigned channel_bit_fmt=2; //1-8bit mono, 2-8bit stereo, 3-16bit mono, 4-16 bit stereo -- checkme encoding seems wrong
shortint unsigned bps=bits_per_samp;
int unsigned data_size=10000000; //aribitrary initial value, to be overwritten later

task write_wave_header ( string filename );
	int fid;
	fid =$fopen(filename,"w");
	$fwrite(fid,"RIFF");
	write_wave_32b (.fid(fid),.data(file_size));
	$fwrite(fid,"WAVEfmt ");
	write_wave_32b (.fid(fid),.data(32'd16)); //length of format data
	write_wave_16b (.fid(fid),.data(fmt_type));
	write_wave_16b (.fid(fid),.data(channels));
	write_wave_32b (.fid(fid),.data(sampling_rate));
	write_wave_32b (.fid(fid),.data(byte_rate));
	write_wave_16b (.fid(fid),.data(channel_bit_fmt));
	write_wave_16b (.fid(fid),.data(bits_per_samp));
	$fwrite(fid,"data");
	write_wave_32b (.fid(fid),.data(data_size));
	$fclose(fid);
endtask // write_wave_header

task write_wave_32b ( int fid, int unsigned data );
	byte unsigned data_bytes[4];
    conv_32b_to_bytes(.data32b(data),.data_bytes(data_bytes));
	$fwrite(fid,"%c",data_bytes[0]);
	$fwrite(fid,"%c",data_bytes[1]);
	$fwrite(fid,"%c",data_bytes[2]);
	$fwrite(fid,"%c",data_bytes[3]);
endtask  

task conv_32b_to_bytes (input int unsigned data32b , output byte unsigned data_bytes[4] );
   int unsigned tmp;
   tmp=data32b;
   data_bytes[0]=tmp%256; tmp=tmp>>8;
   data_bytes[1]=tmp%256; tmp=tmp>>8;
   data_bytes[2]=tmp%256; tmp=tmp>>8;
   data_bytes[3]=tmp%256; tmp=tmp>>8;
endtask

task write_wave_16b ( int fid, int unsigned data );
	byte unsigned data_bytes[2];
    conv_16b_to_bytes(.data16b(data),.data_bytes(data_bytes));
	$fwrite(fid,"%c",data_bytes[0]);
	$fwrite(fid,"%c",data_bytes[1]);
endtask  

task conv_16b_to_bytes (input int unsigned data16b , output byte unsigned data_bytes[2] );
   int unsigned tmp;
   tmp=data16b;
   data_bytes[0]=tmp%256; tmp=tmp>>8;
   data_bytes[1]=tmp%256; tmp=tmp>>8;
endtask

//task write_wave_data (fid,dat);
task write_wave_data8b (int fid, byte dat);
	$fwrite(fid,"%c",dat);
endtask

task write_wave_data16b (int fid, shortint signed dat);
	write_wave_16b (.fid(fid),.data(dat));
endtask

task open_wave_for_data (string filename,output int fid);
	fid=$fopen(filename,"a");
endtask

task update_wave_header (string filename, byte unsigned bytes);
	int fid;
	fid=$fopen(filename,"r+");
	$fseek(fid,40,0); //go to data size section
	$display(bytes);
	write_wave_32b (.fid(fid),.data(bytes));
	$fclose(fid);
endtask

endpackage