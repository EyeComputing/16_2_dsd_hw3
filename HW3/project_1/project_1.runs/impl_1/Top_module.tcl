proc start_step { step } {
  set stopFile ".stop.rst"
  if {[file isfile .stop.rst]} {
    puts ""
    puts "*** Halting run - EA reset detected ***"
    puts ""
    puts ""
    return -code error
  }
  set beginFile ".$step.begin.rst"
  set platform "$::tcl_platform(platform)"
  set user "$::tcl_platform(user)"
  set pid [pid]
  set host ""
  if { [string equal $platform unix] } {
    if { [info exist ::env(HOSTNAME)] } {
      set host $::env(HOSTNAME)
    }
  } else {
    if { [info exist ::env(COMPUTERNAME)] } {
      set host $::env(COMPUTERNAME)
    }
  }
  set ch [open $beginFile w]
  puts $ch "<?xml version=\"1.0\"?>"
  puts $ch "<ProcessHandle Version=\"1\" Minor=\"0\">"
  puts $ch "    <Process Command=\".planAhead.\" Owner=\"$user\" Host=\"$host\" Pid=\"$pid\">"
  puts $ch "    </Process>"
  puts $ch "</ProcessHandle>"
  close $ch
}

proc end_step { step } {
  set endFile ".$step.end.rst"
  set ch [open $endFile w]
  close $ch
}

proc step_failed { step } {
  set endFile ".$step.error.rst"
  set ch [open $endFile w]
  close $ch
}

set_msg_config -id {HDL 9-1061} -limit 100000
set_msg_config -id {HDL 9-1654} -limit 100000

start_step init_design
set rc [catch {
  create_msg_db init_design.pb
  create_project -in_memory -part xc7a100tcsg324-1
  set_property board_part digilentinc.com:nexys4_ddr:part0:1.1 [current_project]
  set_property design_mode GateLvl [current_fileset]
  set_param project.singleFileAddWarning.threshold 0
  set_property webtalk.parent_dir C:/Workspace/DSD/team_project/HW3/project_1/project_1.cache/wt [current_project]
  set_property parent.project_path C:/Workspace/DSD/team_project/HW3/project_1/project_1.xpr [current_project]
  set_property ip_repo_paths c:/Workspace/DSD/team_project/HW3/project_1/project_1.cache/ip [current_project]
  set_property ip_output_repo c:/Workspace/DSD/team_project/HW3/project_1/project_1.cache/ip [current_project]
  add_files -quiet C:/Workspace/DSD/team_project/HW3/project_1/project_1.runs/synth_1/Top_module.dcp
  read_xdc C:/Workspace/DSD/team_project/HW3/project_1/project_1.srcs/constrs_1/imports/constrs/Nexys4DDR_Master.xdc
  link_design -top Top_module -part xc7a100tcsg324-1
  write_hwdef -file Top_module.hwdef
  close_msg_db -file init_design.pb
} RESULT]
if {$rc} {
  step_failed init_design
  return -code error $RESULT
} else {
  end_step init_design
}

start_step opt_design
set rc [catch {
  create_msg_db opt_design.pb
  opt_design 
  write_checkpoint -force Top_module_opt.dcp
  report_drc -file Top_module_drc_opted.rpt
  close_msg_db -file opt_design.pb
} RESULT]
if {$rc} {
  step_failed opt_design
  return -code error $RESULT
} else {
  end_step opt_design
}

start_step place_design
set rc [catch {
  create_msg_db place_design.pb
  implement_debug_core 
  place_design 
  write_checkpoint -force Top_module_placed.dcp
  report_io -file Top_module_io_placed.rpt
  report_utilization -file Top_module_utilization_placed.rpt -pb Top_module_utilization_placed.pb
  report_control_sets -verbose -file Top_module_control_sets_placed.rpt
  close_msg_db -file place_design.pb
} RESULT]
if {$rc} {
  step_failed place_design
  return -code error $RESULT
} else {
  end_step place_design
}

start_step route_design
set rc [catch {
  create_msg_db route_design.pb
  route_design 
  write_checkpoint -force Top_module_routed.dcp
  report_drc -file Top_module_drc_routed.rpt -pb Top_module_drc_routed.pb
  report_timing_summary -warn_on_violation -max_paths 10 -file Top_module_timing_summary_routed.rpt -rpx Top_module_timing_summary_routed.rpx
  report_power -file Top_module_power_routed.rpt -pb Top_module_power_summary_routed.pb -rpx Top_module_power_routed.rpx
  report_route_status -file Top_module_route_status.rpt -pb Top_module_route_status.pb
  report_clock_utilization -file Top_module_clock_utilization_routed.rpt
  close_msg_db -file route_design.pb
} RESULT]
if {$rc} {
  step_failed route_design
  return -code error $RESULT
} else {
  end_step route_design
}

start_step write_bitstream
set rc [catch {
  create_msg_db write_bitstream.pb
  catch { write_mem_info -force Top_module.mmi }
  write_bitstream -force Top_module.bit 
  catch { write_sysdef -hwdef Top_module.hwdef -bitfile Top_module.bit -meminfo Top_module.mmi -file Top_module.sysdef }
  catch {write_debug_probes -quiet -force debug_nets}
  close_msg_db -file write_bitstream.pb
} RESULT]
if {$rc} {
  step_failed write_bitstream
  return -code error $RESULT
} else {
  end_step write_bitstream
}

