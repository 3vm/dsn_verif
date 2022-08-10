A library of Synthesizable RTL and associated verification functions, feel free to use it as you please. Also, please support me as much as you can.

Special mention : 
Many useful functions bundled into importable SV package.
ADC models - flash, counter, delta sigma, pipelined ADC

Fractional-N PLL model

CDR, Clock and Data Recover model 

For further description refer to this book

Ehgu Proposal: An experiment towards an efficient HW design ecosystem
by Thrivikraman Murali
https://www.amazon.com/dp/B07TZGPKC8

If you would like designs, models like these contact@valsid.in


Contents

.

├── ehgu : Simple RTL modules

│   ├── ehgu_basic_pkg.sv : contains frequently used functions - modulo/saturating fixed point arithmentic

│   ├── ehgu_clkdiv_fractional.sv : fractional clock divider

│   ├── ehgu_clkdiv.sv : integer clock divider

│   ├── ehgu_clkgate.sv : glitch free clock gating 

│   ├── ehgu_clkmux.sv : glitch free clock muxing

│   ├── ehgu_cntr.sv : basic binary counter

│   ├── ehgu_config_pkg.sv : configure constants to adjust the bitwidth of basic package

│   ├── ehgu_dly.sv : Delay flip flops in any amount of delay x bit width

│   ├── ehgu_edges.sv : rise and fall edge detector

│   ├── ehgu_fedge.sv : fall edge

│   ├── ehgu_ram_dual_port.sv : Dual port RAM model

│   ├── ehgu_redge.sv : rise edge

│   ├── ehgu_rst_sync.sv : Reset synchronizer

│   ├── ehgu_rst_tree_piped.sv : Pipelined reset tree

│   ├── ehgu_sr_mem.sv : Shift register constructed from RAM

│   ├── ehgu_synqzx.sv : Data synchronizer, N bit x D delay stages

│   ├── tb.sv : testbench to simulate some of the RTL modules

├── examples

│   ├── basic_logic_elements : example of basic logic AND/OR/MUX

│   ├── cdr_model : clock and data recovery model

│   ├── clkdiv : clock divider example

│   ├── clk_freq_meter : clock frequency meter

│   ├── clk_gating : clock gating example

│   ├── clk_muxing : clock muxing example

│   ├── compile_time_lut : Creating lookup table at compile time

│   ├── control_status_register : Config/control/control status register example

│   ├── counter_adc_model : Counter ADC model

│   ├── crc : Cyclic Redundancy Check function

│   ├── decoder : A parameterized large decoder with generate construct

│   ├── delta_sigma_adc_model : Delta Sigma ADC model

│   ├── flash_adc_model : Flash ADC model

│   ├── flip_flops : Exmaple of simple flip flops - DFF, etc..

│   ├── fractional_clkdiv : Fractional clock divider example

│   ├── fractional_pll_model : fractional pll example

│   ├── integrator : integrator model 

│   ├── multicycle_division : example of division operation using multicycle constraint

│   ├── native_parallel_bus : example of basic parallel bus

│   ├── parallel_processing_adder : example of parallel processing with adders

│   ├── pipelined_adc_model : Pipelined ADC model

│   ├── pipelining_adder : How to pipeline an logic? Example Adder

│   ├── pipelining_counter : How to pipeline a counter?

│   ├── pipelining_reset : How to pipeline a reset ?

│   ├── pll_model : PLL Model

│   ├── programmable_gain_amplifier : Model of a Programmable Gain Amplifier

│   ├── ram_dual_port : Model of a dual port RAM

│   ├── ram_single_port : Model of single port RAM

│   ├── retiming_adder : example of retiming using an improperly pipelined adder

│   ├── rom : model of ROM

│   ├── sar_adc_model : Model of Successive approximation Register ADC

│   ├── serializing_datapath : Serializing a regular implementation to save area

│   ├── shift_register_mem : shift register made from dual port RAM

│   ├── sine_wave_lut : creating a look up table for sine function

│   ├── synchronizer : testbench for synchronizer

│   ├── time_del_fsm : example of an FSM that implements fixed time delays

│   └── uvm_hello_world : Hello world example using the UVM library

├── hls : High Level Synthesis examples using the Xilinx Vivado HLS tool

│   ├── add_two_numbers : Adding two numbers C code to verilog code using HLS

├── possible_bugs.txt : some bugs that may be in this library

├── procedural_coding : coding examples for software like programs in SystemVerilog

│   ├── change_problem : coin change problem

│   ├── gcd : Greatest Common Divisor

│   ├── hello_world : Hello World in SystemVerilog

│   ├── linked_list : A basic list implementation with SV class

│   ├── longest_common_subsequence : Bioinformatics longest common subsequence problem

│   ├── manhattan_tourist : Dynamic programming manhattan tourist problem

│   └── prime_factorization : Prime factorization problem

├── quiz : simulation area to check questions in quiz section of the book

├── thee : frequently used verification and modeling code

│   ├── thee_charge_pump.sv : model of an analog charge pump

│   ├── thee_clk_freq_meter.sv : model of a clock frequency meter

│   ├── thee_clk_gen_module.sv : clock generator

│   ├── thee_integrator.sv : model of an integrator

│   ├── thee_low_pass_filter.sv : model of a low pass filter

│   ├── thee_mathsci_consts_pkg.sv : package to keep maths and science constants

│   ├── thee_pfd.sv : model of a phase frequency detector

│   ├── thee_pg_amp.sv : model of programmable gain amplifier

│   ├── thee_pll.sv : model of phase locked loop

│   ├── thee_rand_busdly.sv : model of delay in a bus with random delays

│   ├── thee_sig_analysis_pkg.sv : frequently used functions for analyzing signals

│   ├── thee_utils_pkg.sv : frequently used functions in testbenches

│   └── thee_vco.sv : model of a voltage controlled oscillator

└── useful_scripts

    ├── cdc-using-sta.tcl : a pseudocode to check CDC using STA tool

    ├── clean.bat : clean a run directory in Windows environment

    ├── clean.sh : clean a run directory in linux environment

    ├── compile.bat : compile in Windows

    ├── ehgu_drawing_lib.fig : Drawing library in xfig tool

    ├── ehgu_drawing_lib.svg : Drawing library in inkscape tool

    ├── elaborate.bat : Elaborate in windows

    ├── get_pll_settings.tcl : A script to calculate PLL settings for a desired output frequency

    ├── lines-of-code-created.tcsh : Count lines of SystemVerilog code in the library

    ├── module-blast.tcl : Split a single verilog netlist into multiple files with one module per file

    ├── modules-etc-count.tcsh : count modules, tasks and functions in the code

    ├── periodic-breaks.tcsh : take periodic breaks script, linux env

    ├── periodic-breaks.vbs : periodic break script for windows

    ├── run-quiz.sh : run script for quiz questions

    ├── run.sh : run script for general examples

    ├── SimpleProjMgmtTool.ods : A simple spreadsheet to do chipper project managment

    ├── simulate.bat : simulate in windows

    ├── sriram_edit.tcl : format code with many spaces for easy reading




