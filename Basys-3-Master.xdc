## This file is a general .xdc for the Basys3 rev B board

## Clock signal
set_property PACKAGE_PIN W5 [get_ports {clk}]							
	set_property IOSTANDARD LVCMOS33 [get_ports {clk}]
	create_clock -add -name sys_clk_pin -period 10.00 -waveform {0 5} [get_ports {clk}]
 

##7 segment display
set_property PACKAGE_PIN W7 [get_ports {SEGMENTS[7]}]					
	set_property IOSTANDARD LVCMOS33 [get_ports {SEGMENTS[7]}]
set_property PACKAGE_PIN W6 [get_ports {SEGMENTS[6]}]					
	set_property IOSTANDARD LVCMOS33 [get_ports {SEGMENTS[6]}]
set_property PACKAGE_PIN U8 [get_ports {SEGMENTS[5]}]					
	set_property IOSTANDARD LVCMOS33 [get_ports {SEGMENTS[5]}]
set_property PACKAGE_PIN V8 [get_ports {SEGMENTS[4]}]					
	set_property IOSTANDARD LVCMOS33 [get_ports {SEGMENTS[4]}]
set_property PACKAGE_PIN U5 [get_ports {SEGMENTS[3]}]					
	set_property IOSTANDARD LVCMOS33 [get_ports {SEGMENTS[3]}]
set_property PACKAGE_PIN V5 [get_ports {SEGMENTS[2]}]					
	set_property IOSTANDARD LVCMOS33 [get_ports {SEGMENTS[2]}]
set_property PACKAGE_PIN U7 [get_ports {SEGMENTS[1]}]					
	set_property IOSTANDARD LVCMOS33 [get_ports {SEGMENTS[1]}]

set_property PACKAGE_PIN V7 [get_ports {SEGMENTS[0]}]							
	set_property IOSTANDARD LVCMOS33 [get_ports {SEGMENTS[0]}]

set_property PACKAGE_PIN U2 [get_ports {DISP_EN[3]}]					
	set_property IOSTANDARD LVCMOS33 [get_ports {DISP_EN[3]}]
set_property PACKAGE_PIN U4 [get_ports {DISP_EN[2]}]					
	set_property IOSTANDARD LVCMOS33 [get_ports {DISP_EN[2]}]
set_property PACKAGE_PIN V4 [get_ports {DISP_EN[1]}]					
	set_property IOSTANDARD LVCMOS33 [get_ports {DISP_EN[1]}]
set_property PACKAGE_PIN W4 [get_ports {DISP_EN[0]}]					
	set_property IOSTANDARD LVCMOS33 [get_ports {DISP_EN[0]}]


##Buttons

set_property PACKAGE_PIN T18 [get_ports {up_enable}]						
	set_property IOSTANDARD LVCMOS33 [get_ports {up_enable}]

set_property PACKAGE_PIN U17 [get_ports {down_enable}]						
	set_property IOSTANDARD LVCMOS33 [get_ports {down_enable}]
 

set_property PACKAGE_PIN P18 [get_ports {led_clk}]					
	set_property IOSTANDARD LVCMOS33 [get_ports {led_clk}]


