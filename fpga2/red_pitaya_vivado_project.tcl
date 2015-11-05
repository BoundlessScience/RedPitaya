################################################################################
# Vivado tcl script for building RedPitaya FPGA in non project mode
#
# Usage:
# vivado -mode batch -source red_pitaya_vivado_project.tcl
################################################################################

################################################################################
# define paths
################################################################################

set path_rtl rtl
set path_ip  ip
set path_sdc sdc

################################################################################
# setup an in memory project
################################################################################

set part xc7z010clg400-1

create_project -part $part -force redpitaya ./project

################################################################################
# create PS BD (processing system block design)
################################################################################

# create PS BD
source                            $path_ip/system_bd.tcl

# generate SDK files
generate_target all [get_files    system.bd]

################################################################################
# read files:
# 1. RTL design sources
# 2. IP database files
# 3. constraints
################################################################################

read_verilog                      ./project/redpitaya.srcs/sources_1/bd/system/hdl/system_wrapper.v

add_files                         $path_rtl/axi_master.sv
add_files                         $path_rtl/axi_slave.sv
add_files                         $path_rtl/axi_wr_fifo.sv

add_files                         $path_rtl/red_pitaya_ams.sv
add_files                         $path_rtl/red_pitaya_hk.sv
add_files                         $path_rtl/red_pitaya_calib.sv
add_files                         $path_rtl/red_pitaya_pid_block.sv
add_files                         $path_rtl/red_pitaya_pid.sv
add_files                         $path_rtl/red_pitaya_pll.sv
add_files                         $path_rtl/red_pitaya_ps.sv
add_files                         $path_rtl/red_pitaya_top.sv
add_files                         $path_rtl/pdm.sv
add_files                         $path_rtl/pwm.sv
add_files                         $path_rtl/linear.sv
add_files                         $path_rtl/asg_top.sv
add_files                         $path_rtl/asg.sv
add_files                         $path_rtl/scope_top.sv
add_files                         $path_rtl/scope_filter.sv
add_files                         $path_rtl/scope_dec_avg.sv
add_files                         $path_rtl/scope_edge.sv

add_files -fileset constrs_1      $path_sdc/red_pitaya.xdc

import_files -force

update_compile_order -fileset sources_1

################################################################################
################################################################################

#start_gui
