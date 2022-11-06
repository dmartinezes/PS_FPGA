transcript on
if {[file exists gate_work]} {
	vdel -lib gate_work -all
}
vlib gate_work
vmap work gate_work

vlog -vlog01compat -work work +incdir+. {SEC_FILTER_6_1200mv_85c_slow.vo}

vlog -vlog01compat -work work +incdir+C:/Users/Usuario/Desktop/Procesado_Digital_de_la_Senyal_en_FPGA/P4/E4_Quartus {C:/Users/Usuario/Desktop/Procesado_Digital_de_la_Senyal_en_FPGA/P4/E4_Quartus/TB_SEC_FILTER.v}

vsim -t 1ps +transport_int_delays +transport_path_delays -L altera_ver -L cycloneive_ver -L gate_work -L work -voptargs="+acc"  TB_SEC_FILTER

add wave *
view structure
view signals
run -all
