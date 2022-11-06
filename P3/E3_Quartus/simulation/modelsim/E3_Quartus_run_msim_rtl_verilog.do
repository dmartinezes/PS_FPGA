transcript on
if {[file exists rtl_work]} {
	vdel -lib rtl_work -all
}
vlib rtl_work
vmap work rtl_work

vlog -vlog01compat -work work +incdir+C:/Users/elnes/Desktop/E3/E3_Quartus {C:/Users/elnes/Desktop/E3/E3_Quartus/CIC_pc.v}
vlog -vlog01compat -work work +incdir+C:/Users/elnes/Desktop/E3/E3_Quartus {C:/Users/elnes/Desktop/E3/E3_Quartus/R_INT.v}
vlog -vlog01compat -work work +incdir+C:/Users/elnes/Desktop/E3/E3_Quartus {C:/Users/elnes/Desktop/E3/E3_Quartus/INT.v}
vlog -vlog01compat -work work +incdir+C:/Users/elnes/Desktop/E3/E3_Quartus {C:/Users/elnes/Desktop/E3/E3_Quartus/COMB.v}
vlog -vlog01compat -work work +incdir+C:/Users/elnes/Desktop/E3/E3_Quartus {C:/Users/elnes/Desktop/E3/E3_Quartus/CIC.v}

