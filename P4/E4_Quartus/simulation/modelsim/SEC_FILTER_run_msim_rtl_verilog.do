transcript on
if {[file exists rtl_work]} {
	vdel -lib rtl_work -all
}
vlib rtl_work
vmap work rtl_work

vlog -vlog01compat -work work +incdir+C:/Users/Usuario/Desktop/Procesado_Digital_de_la_Senyal_en_FPGA/P4/E4_Quartus {C:/Users/Usuario/Desktop/Procesado_Digital_de_la_Senyal_en_FPGA/P4/E4_Quartus/SEC_FILTER.v}
vlog -vlog01compat -work work +incdir+C:/Users/Usuario/Desktop/Procesado_Digital_de_la_Senyal_en_FPGA/P4/E4_Quartus {C:/Users/Usuario/Desktop/Procesado_Digital_de_la_Senyal_en_FPGA/P4/E4_Quartus/REG_MUX.v}
vlog -vlog01compat -work work +incdir+C:/Users/Usuario/Desktop/Procesado_Digital_de_la_Senyal_en_FPGA/P4/E4_Quartus {C:/Users/Usuario/Desktop/Procesado_Digital_de_la_Senyal_en_FPGA/P4/E4_Quartus/MULT_ACC.v}
vlog -vlog01compat -work work +incdir+C:/Users/Usuario/Desktop/Procesado_Digital_de_la_Senyal_en_FPGA/P4/E4_Quartus {C:/Users/Usuario/Desktop/Procesado_Digital_de_la_Senyal_en_FPGA/P4/E4_Quartus/CONTROL.v}
vlog -vlog01compat -work work +incdir+C:/Users/Usuario/Desktop/Procesado_Digital_de_la_Senyal_en_FPGA/P4/E4_Quartus {C:/Users/Usuario/Desktop/Procesado_Digital_de_la_Senyal_en_FPGA/P4/E4_Quartus/ROM.v}

vlog -vlog01compat -work work +incdir+C:/Users/Usuario/Desktop/Procesado_Digital_de_la_Senyal_en_FPGA/P4/E4_Quartus {C:/Users/Usuario/Desktop/Procesado_Digital_de_la_Senyal_en_FPGA/P4/E4_Quartus/TB_SEC_FILTER.v}

vsim -t 1ps -L altera_ver -L lpm_ver -L sgate_ver -L altera_mf_ver -L altera_lnsim_ver -L cycloneive_ver -L rtl_work -L work -voptargs="+acc"  TB_SEC_FILTER

add wave *
view structure
view signals
run -all
