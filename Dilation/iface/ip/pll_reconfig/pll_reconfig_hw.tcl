# (C) 2001-2012 Altera Corporation. All rights reserved.
# Your use of Altera Corporation's design tools, logic functions and other 
# software and tools, and its AMPP partner logic functions, and any output 
# files any of the foregoing (including device programming or simulation 
# files), and any associated documentation or information are expressly subject 
# to the terms and conditions of the Altera Program License Subscription 
# Agreement, Altera MegaCore Function License Agreement, or other applicable 
# license agreement, including, without limitation, that your use is for the 
# sole purpose of programming logic devices manufactured by Altera and sold by 
# Altera or its authorized distributors.  Please refer to the applicable 
# agreement for further details.


# (C) 2001-2010 Altera Corporation. All rights reserved.
# Your use of Altera Corporation's design tools, logic functions and other 
# software and tools, and its AMPP partner logic functions, and any output 
# files any of the foregoing (including device programming or simulation 
# files), and any associated documentation or information are expressly subject 
# to the terms and conditions of the Altera Program License Subscription 
# Agreement, Altera MegaCore Function License Agreement, or other applicable 
# license agreement, including, without limitation, that your use is for the 
# sole purpose of programming logic devices manufactured by Altera and sold by 
# Altera or its authorized distributors.  Please refer to the applicable 
# agreement for further details.


# TCL File Generated by Component Editor 9.1
# Wed Jul 01 15:56:26 PDT 2009
# DO NOT MODIFY


# +-----------------------------------
# | 
# | pll "pll" v1.0
# | null 2009.11.05.13:57:30
# | 
# | 
# | D:/stratixv_pll/q10.0_58_acds/pll.v
# | 
# |    ./pll.v syn, sim
# | 
# +-----------------------------------

# +-----------------------------------
# | request TCL package from ACDS 10.0
# | 
package require -exact sopc 11.0
# | 
# +-----------------------------------

add_display_item "" "General" GROUP tab
add_display_item "" "MIF Streaming" GROUP tab

# +-----------------------------------
# | module pll reconfig
# | 
set_module_property NAME acl_pll_reconfig
set_module_property VERSION 12.1
set_module_property INTERNAL false
set_module_property GROUP "PLL"
set_module_property AUTHOR "Altera Corporation"
set_module_property DISPLAY_NAME "ACL Altera PLL Reconfig"
set_module_property DESCRIPTION "(Fixed) Altera Phase-Locked Loop Reconfiguration Block(ALTERA_PLL_RECONFIG)"
set_module_property DATASHEET_URL ""
set_module_property LIBRARIES {ieee.std_logic_1164.all ieee.std_logic_arith.all ieee.std_logic_unsigned.all std.standard.all}
# set_module_property INSTANTIATE_IN_SYSTEM_MODULE false
set_module_property EDITABLE true
set_module_property SIMULATION_MODEL_IN_VHDL true
set_module_property SIMULATION_MODEL_IN_VERILOG true  
#setting the callbacks
set_module_property ELABORATION_CALLBACK elaboration_callback
#set_module_property GENERATION_CALLBACK generation_callback
#adding the HDL file and assigning appropriate property 
#add_fileset sim_vhdl SIM_VHDL generate_vhdl_sim
#add_fileset sim_verilog SIM_VERILOG generate_verilog_sim
#add_fileset quartus_synth QUARTUS_SYNTH generate_synth
add_file altera_pll_reconfig_mif_reader.v SYNTHESIS
add_file altera_pll_reconfig_core.v SYNTHESIS
add_file altera_pll_reconfig_top.v SYNTHESIS
#	add_file ${outdir}${outputname}_sim.v SIMULATION
set_module_property TOP_LEVEL_HDL_FILE altera_pll_reconfig_top.v
set_module_property TOP_LEVEL_HDL_MODULE altera_pll_reconfig_top

proc generate_vhdl_sim { name } {
    add_fileset_file altera_pll_reconfig_top.v VERILOG_ENCRYPT PATH [file join mentor altera_pll_reconfig_top.v] {MENTOR_SPECIFIC}

}

# +-----------------------------------
#declare constants for widths
set w_rd 32
set w_wd 32
set w_add 6
set reconf_width 64
# +-----------------------------------
#add_display_item "" "General" GROUP tab
# +-----------------------------------

# +-----------------------------------
# | parameters
# |
## setting for General pll
#####
add_parameter device_family STRING 
set_parameter_property device_family VISIBLE false
set_parameter_property device_family SYSTEM_INFO {DEVICE_FAMILY}
set_parameter_property device_family HDL_PARAMETER true
set_parameter_property device_family AFFECTS_GENERATION false

add_parameter reconf_width int 
set_parameter_property reconf_width DEFAULT_VALUE 64
set_parameter_property reconf_width ALLOWED_RANGES {64 128 256}
set_parameter_property reconf_width ENABLED false
set_parameter_property reconf_width DISPLAY_NAME "Reconfig to/from PLL Width"
set_parameter_property reconf_width UNITS None
set_parameter_property reconf_width DISPLAY_HINT ""
set_parameter_property reconf_width AFFECTS_GENERATION false
set_parameter_property reconf_width HDL_PARAMETER true
set_parameter_property reconf_width DESCRIPTION "Specifies the width of the port that configures the PLL."
add_display_item "General" reconf_width parameter

### MIF STREAMING
# ENABLE_MIF
add_parameter ENABLE_MIF INTEGER 0
set_parameter_property ENABLE_MIF DEFAULT_VALUE 0
set_parameter_property ENABLE_MIF DISPLAY_NAME "Enable MIF Streaming"
set_parameter_property ENABLE_MIF UNITS None
set_parameter_property ENABLE_MIF ALLOWED_RANGES {0 1}
set_parameter_property ENABLE_MIF DISPLAY_HINT boolean
set_parameter_property ENABLE_MIF AFFECTS_ELABORATION true
set_parameter_property ENABLE_MIF AFFECTS_GENERATION true
set_parameter_property ENABLE_MIF HDL_PARAMETER true
set_parameter_property ENABLE_MIF DESCRIPTION "Enable MIF streaming for PLL reconfiguration"
add_display_item "MIF Streaming" ENABLE_MIF parameter

# MIF_FILE_NAME
add_parameter MIF_FILE_NAME STRING ""
set_parameter_property MIF_FILE_NAME DISPLAY_NAME "Path to MIF file"
set_parameter_property MIF_FILE_NAME UNITS None
set_parameter_property MIF_FILE_NAME DISPLAY_HINT ""
set_parameter_property MIF_FILE_NAME AFFECTS_ELABORATION true
set_parameter_property MIF_FILE_NAME AFFECTS_GENERATION true
set_parameter_property MIF_FILE_NAME HDL_PARAMETER true
set_parameter_property MIF_FILE_NAME DESCRIPTION "Memory Initialization File for reconfiguration"
add_display_item "MIF Streaming" MIF_FILE_NAME parameter



# +-----------------------------------
# | elaboration callback 
# | 
# | 
# +-----------------------------------
proc elaboration_callback {} {
    set supported_families [list "Stratix V" "Arria V" "Cyclone V" "Arria V GZ"]
	set current_family [get_parameter_value device_family]
	if {[lsearch $supported_families $current_family] == -1} {
		send_message error "The selected device family is not supported. Please select $supported_families."
	}

    set mif_enabled [get_parameter_value ENABLE_MIF]

    set_parameter_property MIF_FILE_NAME ENABLED $mif_enabled
}

# +-----------------------------------
# | Generation callback 
# | 
# | 
# +-----------------------------------
proc generation_callback {} {
	send_message info "Starting Generation"
	# get generation settings
	set language [get_generation_property HDL_LANGUAGE]
	set outdir [get_generation_property OUTPUT_DIRECTORY ]
	set outputname [get_generation_property OUTPUT_NAME ]
#	add_file ${outdir}${outputname}_sim.v SIMULATION
	set_module_property TOP_LEVEL_HDL_FILE altera_pll_reconfig_top.v
	set_module_property TOP_LEVEL_HDL_MODULE altera_pll_reconfig_top.v
	
	
}



# +-----------------------------------
# | interface items
# | 
# | 
# +-----------------------------------

# +-----------------------------------
# | declaring the clock interface mgmt_clk
# +------------------------------------ 
add_interface mgmt_clk clock sink
add_interface_port mgmt_clk mgmt_clk clk input 1
# +-----------------------------------
# | declaring the reset interface mgmt_reset with associate clk mgmt_clk
# +------------------------------------ 
add_interface mgmt_reset reset sink mgmt_clk
add_interface_port mgmt_reset mgmt_reset reset input 1
# +-----------------------------------
# | declaring the avalon interface
# +------------------------------------ 
add_interface mgmt_avalon_slave avalon slave
set_interface_property mgmt_avalon_slave associatedClock mgmt_clk
set_interface_property mgmt_avalon_slave associatedReset mgmt_reset
set_interface_property mgmt_avalon_slave readLatency 3

#declare avalon ports belonging to the mgmt_avalon_slave interface
add_interface_port mgmt_avalon_slave mgmt_readdata readdata output $w_rd
add_interface_port mgmt_avalon_slave mgmt_waitrequest waitrequest output 1
set_interface_assignment mgmt_waitrequest "ui.blockdiagram.direction" OUTPUT
add_interface_port mgmt_avalon_slave mgmt_read read input 1
add_interface_port mgmt_avalon_slave mgmt_write write input 1
add_interface_port mgmt_avalon_slave mgmt_address address input $w_add
add_interface_port mgmt_avalon_slave mgmt_writedata writedata input $w_wd

#declare the reconfig conduit to the PLL
add_interface reconfig_to_pll conduit start
set_interface_assignment reconfig_to_pll "ui.blockdiagram.direction" OUTPUT
add_interface_port reconfig_to_pll reconfig_to_pll reconfig_to_pll output $reconf_width
add_interface reconfig_from_pll conduit end
add_interface_port reconfig_from_pll reconfig_from_pll reconfig_from_pll input $reconf_width

