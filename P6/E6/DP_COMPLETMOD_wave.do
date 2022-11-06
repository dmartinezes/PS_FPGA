onerror {resume}
quietly WaveActivateNextPane {} 0
add wave -noupdate /TB_DP_COMPLETMOD/dp_completmod/sin_wave
add wave -noupdate /TB_DP_COMPLETMOD/rst
add wave -noupdate /TB_DP_COMPLETMOD/clk
add wave -noupdate /TB_DP_COMPLETMOD/val_in
add wave -noupdate /TB_DP_COMPLETMOD/val_out
add wave -noupdate -expand -group Inputs -color Cyan -radix unsigned /TB_DP_COMPLETMOD/c_fm_am
add wave -noupdate -expand -group Inputs -color Cyan -radix decimal /TB_DP_COMPLETMOD/c_source
add wave -noupdate -expand -group Inputs -color Cyan -radix decimal /TB_DP_COMPLETMOD/frec_mod
add wave -noupdate -expand -group Inputs -color Cyan -radix decimal /TB_DP_COMPLETMOD/frec_por
add wave -noupdate -expand -group Inputs -color Cyan -radix decimal /TB_DP_COMPLETMOD/im_am
add wave -noupdate -expand -group Inputs -color Cyan -radix decimal /TB_DP_COMPLETMOD/im_fm
add wave -noupdate -expand -group {Output Signals comparison} -color Orange -format Analog-Step -height 74 -max 8191.0 -min -8192.0 -subitemconfig {{/TB_DP_COMPLETMOD/dout_M[13]} {-color Orange} {/TB_DP_COMPLETMOD/dout_M[12]} {-color Orange} {/TB_DP_COMPLETMOD/dout_M[11]} {-color Orange} {/TB_DP_COMPLETMOD/dout_M[10]} {-color Orange} {/TB_DP_COMPLETMOD/dout_M[9]} {-color Orange} {/TB_DP_COMPLETMOD/dout_M[8]} {-color Orange} {/TB_DP_COMPLETMOD/dout_M[7]} {-color Orange} {/TB_DP_COMPLETMOD/dout_M[6]} {-color Orange} {/TB_DP_COMPLETMOD/dout_M[5]} {-color Orange} {/TB_DP_COMPLETMOD/dout_M[4]} {-color Orange} {/TB_DP_COMPLETMOD/dout_M[3]} {-color Orange} {/TB_DP_COMPLETMOD/dout_M[2]} {-color Orange} {/TB_DP_COMPLETMOD/dout_M[1]} {-color Orange} {/TB_DP_COMPLETMOD/dout_M[0]} {-color Orange}} /TB_DP_COMPLETMOD/dout_M
add wave -noupdate -expand -group {Output Signals comparison} -color Orange -format Analog-Step -height 74 -max 7874.9999999999991 -min -7876.0 -subitemconfig {{/TB_DP_COMPLETMOD/dout_F[13]} {-color Orange} {/TB_DP_COMPLETMOD/dout_F[12]} {-color Orange} {/TB_DP_COMPLETMOD/dout_F[11]} {-color Orange} {/TB_DP_COMPLETMOD/dout_F[10]} {-color Orange} {/TB_DP_COMPLETMOD/dout_F[9]} {-color Orange} {/TB_DP_COMPLETMOD/dout_F[8]} {-color Orange} {/TB_DP_COMPLETMOD/dout_F[7]} {-color Orange} {/TB_DP_COMPLETMOD/dout_F[6]} {-color Orange} {/TB_DP_COMPLETMOD/dout_F[5]} {-color Orange} {/TB_DP_COMPLETMOD/dout_F[4]} {-color Orange} {/TB_DP_COMPLETMOD/dout_F[3]} {-color Orange} {/TB_DP_COMPLETMOD/dout_F[2]} {-color Orange} {/TB_DP_COMPLETMOD/dout_F[1]} {-color Orange} {/TB_DP_COMPLETMOD/dout_F[0]} {-color Orange}} /TB_DP_COMPLETMOD/dout_F
add wave -noupdate -expand -group {Test Signals} -color {Dark Orchid} /TB_DP_COMPLETMOD/error_cnt
add wave -noupdate -expand -group {Test Signals} -color {Dark Orchid} /TB_DP_COMPLETMOD/sample_cnt
add wave -noupdate -group DDS_test /TB_DP_COMPLETMOD/dp_completmod/dds_test/P
add wave -noupdate -group DDS_test -format Analog-Step -height 74 -max 8185.9999999999991 -min -8186.0 /TB_DP_COMPLETMOD/dp_completmod/sin_wave
add wave -noupdate -group Sec_filter -format Analog-Step -height 74 -max 14392.0 -min -14393.0 -radix decimal -childformat {{{/TB_DP_COMPLETMOD/dp_completmod/dout_comp[18]} -radix decimal} {{/TB_DP_COMPLETMOD/dp_completmod/dout_comp[17]} -radix decimal} {{/TB_DP_COMPLETMOD/dp_completmod/dout_comp[16]} -radix decimal} {{/TB_DP_COMPLETMOD/dp_completmod/dout_comp[15]} -radix decimal} {{/TB_DP_COMPLETMOD/dp_completmod/dout_comp[14]} -radix decimal} {{/TB_DP_COMPLETMOD/dp_completmod/dout_comp[13]} -radix decimal} {{/TB_DP_COMPLETMOD/dp_completmod/dout_comp[12]} -radix decimal} {{/TB_DP_COMPLETMOD/dp_completmod/dout_comp[11]} -radix decimal} {{/TB_DP_COMPLETMOD/dp_completmod/dout_comp[10]} -radix decimal} {{/TB_DP_COMPLETMOD/dp_completmod/dout_comp[9]} -radix decimal} {{/TB_DP_COMPLETMOD/dp_completmod/dout_comp[8]} -radix decimal} {{/TB_DP_COMPLETMOD/dp_completmod/dout_comp[7]} -radix decimal} {{/TB_DP_COMPLETMOD/dp_completmod/dout_comp[6]} -radix decimal} {{/TB_DP_COMPLETMOD/dp_completmod/dout_comp[5]} -radix decimal} {{/TB_DP_COMPLETMOD/dp_completmod/dout_comp[4]} -radix decimal} {{/TB_DP_COMPLETMOD/dp_completmod/dout_comp[3]} -radix decimal} {{/TB_DP_COMPLETMOD/dp_completmod/dout_comp[2]} -radix decimal} {{/TB_DP_COMPLETMOD/dp_completmod/dout_comp[1]} -radix decimal} {{/TB_DP_COMPLETMOD/dp_completmod/dout_comp[0]} -radix decimal}} -subitemconfig {{/TB_DP_COMPLETMOD/dp_completmod/dout_comp[18]} {-height 15 -radix decimal} {/TB_DP_COMPLETMOD/dp_completmod/dout_comp[17]} {-height 15 -radix decimal} {/TB_DP_COMPLETMOD/dp_completmod/dout_comp[16]} {-height 15 -radix decimal} {/TB_DP_COMPLETMOD/dp_completmod/dout_comp[15]} {-height 15 -radix decimal} {/TB_DP_COMPLETMOD/dp_completmod/dout_comp[14]} {-height 15 -radix decimal} {/TB_DP_COMPLETMOD/dp_completmod/dout_comp[13]} {-height 15 -radix decimal} {/TB_DP_COMPLETMOD/dp_completmod/dout_comp[12]} {-height 15 -radix decimal} {/TB_DP_COMPLETMOD/dp_completmod/dout_comp[11]} {-height 15 -radix decimal} {/TB_DP_COMPLETMOD/dp_completmod/dout_comp[10]} {-height 15 -radix decimal} {/TB_DP_COMPLETMOD/dp_completmod/dout_comp[9]} {-height 15 -radix decimal} {/TB_DP_COMPLETMOD/dp_completmod/dout_comp[8]} {-height 15 -radix decimal} {/TB_DP_COMPLETMOD/dp_completmod/dout_comp[7]} {-height 15 -radix decimal} {/TB_DP_COMPLETMOD/dp_completmod/dout_comp[6]} {-height 15 -radix decimal} {/TB_DP_COMPLETMOD/dp_completmod/dout_comp[5]} {-height 15 -radix decimal} {/TB_DP_COMPLETMOD/dp_completmod/dout_comp[4]} {-height 15 -radix decimal} {/TB_DP_COMPLETMOD/dp_completmod/dout_comp[3]} {-height 15 -radix decimal} {/TB_DP_COMPLETMOD/dp_completmod/dout_comp[2]} {-height 15 -radix decimal} {/TB_DP_COMPLETMOD/dp_completmod/dout_comp[1]} {-height 15 -radix decimal} {/TB_DP_COMPLETMOD/dp_completmod/dout_comp[0]} {-height 15 -radix decimal}} /TB_DP_COMPLETMOD/dp_completmod/dout_comp
add wave -noupdate -group CIC_pc -format Analog-Step -height 74 -max 56740000000.000008 -min -55955400000.0 /TB_DP_COMPLETMOD/dp_completmod/cic/cic1/o_data
add wave -noupdate -group CIC -format Analog-Step -height 74 -max 22222.000000000004 -min -22224.0 /TB_DP_COMPLETMOD/dp_completmod/data_out_cic
add wave -noupdate -group DP_MOD -format Analog-Step -height 74 -max 736689.0 -min -401198.0 /TB_DP_COMPLETMOD/dp_completmod/dp_mod/sum1_reg
add wave -noupdate -group DP_MOD -format Analog-Step -height 74 -max 8388520.0 -min -8388570.0 /TB_DP_COMPLETMOD/dp_completmod/dp_mod/D1/acc_out
add wave -noupdate -group DP_MOD -format Analog-Step -height 74 -max 32767.0 -min -32767.0 /TB_DP_COMPLETMOD/dp_completmod/dp_mod/sin_wave_out
add wave -noupdate -group DP_MOD -format Analog-Step -height 74 -max 27494.0 -min 5272.0 /TB_DP_COMPLETMOD/dp_completmod/dp_mod/out_mux2
add wave -noupdate -group DP_MOD -format Analog-Step -height 74 -max 22219.0 -min -22222.0 /TB_DP_COMPLETMOD/dp_completmod/dp_mod/multB_out_trunc
add wave -noupdate -group DP_MOD -format Analog-Step -height 74 -max 26026.000000000004 -min -27126.0 /TB_DP_COMPLETMOD/dp_completmod/o_data_dp
add wave -noupdate /TB_DP_COMPLETMOD/dp_completmod/o_data
add wave -noupdate /TB_DP_COMPLETMOD/dp_completmod/val_out_dds
add wave -noupdate /TB_DP_COMPLETMOD/dp_completmod/val_out_comp
add wave -noupdate /TB_DP_COMPLETMOD/dp_completmod/cic/cic1/val_in
add wave -noupdate /TB_DP_COMPLETMOD/dp_completmod/cic/cic1/val_comb1
add wave -noupdate /TB_DP_COMPLETMOD/dp_completmod/cic/cic1/val_comb2
add wave -noupdate /TB_DP_COMPLETMOD/dp_completmod/cic/cic1/val_comb3
add wave -noupdate /TB_DP_COMPLETMOD/dp_completmod/cic/cic1/val_int1
add wave -noupdate /TB_DP_COMPLETMOD/dp_completmod/cic/cic1/val_int2
add wave -noupdate /TB_DP_COMPLETMOD/dp_completmod/cic/cic1/val_int3
add wave -noupdate /TB_DP_COMPLETMOD/dp_completmod/cic/cic1/val_out
add wave -noupdate /TB_DP_COMPLETMOD/dp_completmod/rst_dp
TreeUpdate [SetDefaultTree]
WaveRestoreCursors {{Cursor 1} {8221000 ps} 0} {{Cursor 2} {19660621000 ps} 0}
quietly wave cursor active 1
configure wave -namecolwidth 400
configure wave -valuecolwidth 100
configure wave -justifyvalue left
configure wave -signalnamewidth 0
configure wave -snapdistance 10
configure wave -datasetprefix 0
configure wave -rowmargin 4
configure wave -childrowmargin 2
configure wave -gridoffset 0
configure wave -gridperiod 1
configure wave -griddelta 40
configure wave -timeline 0
configure wave -timelineunits ps
update
WaveRestoreZoom {0 ps} {1575031500 ps}
