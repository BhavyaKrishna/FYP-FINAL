set_property SRC_FILE_INFO {cfile:{d:/Repository/FYP-FINAL/project final files/project_1/project_1.srcs/sources_1/ip/cordic_1/cordic_1_ooc.xdc} rfile:../../../../../project_1.srcs/sources_1/ip/cordic_1/cordic_1_ooc.xdc id:1 order:EARLY scoped_inst:U0} [current_design]
set_property SRC_FILE_INFO {cfile:{D:/Repository/FYP-FINAL/project final files/project_1/project_1.runs/cordic_1_synth_1/dont_touch.xdc} rfile:../../../dont_touch.xdc id:2} [current_design]
set_property src_info {type:SCOPED_XDC file:1 line:55 export:INPUT save:INPUT read:FILTER_OUT_OF_CONTEXT} [current_design]
create_clock -period 1000.000 -name aclk [get_ports aclk]
set_property src_info {type:XDC file:2 line:9 export:INPUT save:INPUT read:READ} [current_design]
set_property DONT_TOUCH true [get_cells U0]