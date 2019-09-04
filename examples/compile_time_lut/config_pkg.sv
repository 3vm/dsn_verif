
package config_pkg ;

localparam POWER_ENTRIES=10;
typedef logic [15:0] power3_lut_t [POWER_ENTRIES];

function automatic power3_lut_t create_power3_table ();
	power3_lut_t lut;
	for (int i = 0 ; i<POWER_ENTRIES; i++) begin
		lut[i] = 3**i;
	end
	return lut;
endfunction

parameter power3_lut_t power3=create_power3_table();

endpackage
