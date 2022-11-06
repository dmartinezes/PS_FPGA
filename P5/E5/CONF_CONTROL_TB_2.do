onerror {resume}
quietly WaveActivateNextPane {} 0
add wave -noupdate /CONF_CONTROL_TB/clk
add wave -noupdate /CONF_CONTROL_TB/rst
add wave -noupdate -divider {TX-RX CONTROL}
add wave -noupdate -radix hexadecimal -childformat {{{/CONF_CONTROL_TB/rxdw[7]} -radix hexadecimal} {{/CONF_CONTROL_TB/rxdw[6]} -radix hexadecimal} {{/CONF_CONTROL_TB/rxdw[5]} -radix hexadecimal} {{/CONF_CONTROL_TB/rxdw[4]} -radix hexadecimal} {{/CONF_CONTROL_TB/rxdw[3]} -radix hexadecimal} {{/CONF_CONTROL_TB/rxdw[2]} -radix hexadecimal} {{/CONF_CONTROL_TB/rxdw[1]} -radix hexadecimal} {{/CONF_CONTROL_TB/rxdw[0]} -radix hexadecimal}} -subitemconfig {{/CONF_CONTROL_TB/rxdw[7]} {-height 15 -radix hexadecimal} {/CONF_CONTROL_TB/rxdw[6]} {-height 15 -radix hexadecimal} {/CONF_CONTROL_TB/rxdw[5]} {-height 15 -radix hexadecimal} {/CONF_CONTROL_TB/rxdw[4]} {-height 15 -radix hexadecimal} {/CONF_CONTROL_TB/rxdw[3]} {-height 15 -radix hexadecimal} {/CONF_CONTROL_TB/rxdw[2]} {-height 15 -radix hexadecimal} {/CONF_CONTROL_TB/rxdw[1]} {-height 15 -radix hexadecimal} {/CONF_CONTROL_TB/rxdw[0]} {-height 15 -radix hexadecimal}} /CONF_CONTROL_TB/rxdw
add wave -noupdate /CONF_CONTROL_TB/rxrdy
add wave -noupdate /CONF_CONTROL_TB/txbusy
add wave -noupdate -radix hexadecimal /CONF_CONTROL_TB/txdw
add wave -noupdate /CONF_CONTROL_TB/txena
add wave -noupdate -divider {REGISTROS CONF}
add wave -noupdate -radix hexadecimal /CONF_CONTROL_TB/r_frec_mod
add wave -noupdate -radix hexadecimal /CONF_CONTROL_TB/r_frec_por
add wave -noupdate -radix hexadecimal /CONF_CONTROL_TB/r_im_am
add wave -noupdate -radix hexadecimal /CONF_CONTROL_TB/r_im_fm
add wave -noupdate -radix hexadecimal /CONF_CONTROL_TB/r_control
add wave -noupdate -expand -group {Main Control} /CONF_CONTROL_TB/DUT/C3/done_wr
add wave -noupdate -expand -group {Main Control} -radix decimal -childformat {{{/CONF_CONTROL_TB/DUT/C3/C1/sleds[2]} -radix decimal} {{/CONF_CONTROL_TB/DUT/C3/C1/sleds[1]} -radix decimal} {{/CONF_CONTROL_TB/DUT/C3/C1/sleds[0]} -radix decimal}} -subitemconfig {{/CONF_CONTROL_TB/DUT/C3/C1/sleds[2]} {-height 15 -radix decimal} {/CONF_CONTROL_TB/DUT/C3/C1/sleds[1]} {-height 15 -radix decimal} {/CONF_CONTROL_TB/DUT/C3/C1/sleds[0]} {-height 15 -radix decimal}} /CONF_CONTROL_TB/DUT/C3/C1/sleds
add wave -noupdate -expand -group {RD Control} -radix unsigned /CONF_CONTROL_TB/DUT/C3/C3/rd_leds
add wave -noupdate -expand -group {RD Control} /CONF_CONTROL_TB/DUT/C3/C3/cont_enable
add wave -noupdate -expand -group {RD Control} -radix unsigned /CONF_CONTROL_TB/DUT/C3/C3/count
add wave -noupdate -expand -group REGS_CONF -radix hexadecimal /CONF_CONTROL_TB/DUT/C2/reg_array
add wave -noupdate -expand -group REGS_CONF -radix hexadecimal /CONF_CONTROL_TB/DUT/C2/reg_array_confregs
add wave -noupdate -expand -group REGS_CONF -radix hexadecimal /CONF_CONTROL_TB/DUT/C2/reg_array_txregs
add wave -noupdate -expand -group REGS_CONF -radix hexadecimal /CONF_CONTROL_TB/DUT/C2/reg_array_out
add wave -noupdate /CONF_CONTROL_TB/DUT/C3/C3/txbusy
add wave -noupdate /CONF_CONTROL_TB/DUT/C3/C3/load_txregs
add wave -noupdate /CONF_CONTROL_TB/DUT/C3/C3/shift_txregs
add wave -noupdate -radix hexadecimal /CONF_CONTROL_TB/txdw
add wave -noupdate /CONF_CONTROL_TB/DUT/C3/C3/txena
add wave -noupdate /CONF_CONTROL_TB/DUT/C3/C3/done_rd
add wave -noupdate /CONF_CONTROL_TB/DUT/C3/C3/state
add wave -noupdate /CONF_CONTROL_TB/DUT/C3/C3/count
add wave -noupdate -radix hexadecimal -childformat {{{/CONF_CONTROL_TB/DUT/C2/reg_array_confregs[10]} -radix hexadecimal} {{/CONF_CONTROL_TB/DUT/C2/reg_array_confregs[9]} -radix hexadecimal} {{/CONF_CONTROL_TB/DUT/C2/reg_array_confregs[8]} -radix hexadecimal} {{/CONF_CONTROL_TB/DUT/C2/reg_array_confregs[7]} -radix hexadecimal} {{/CONF_CONTROL_TB/DUT/C2/reg_array_confregs[6]} -radix hexadecimal} {{/CONF_CONTROL_TB/DUT/C2/reg_array_confregs[5]} -radix hexadecimal} {{/CONF_CONTROL_TB/DUT/C2/reg_array_confregs[4]} -radix hexadecimal} {{/CONF_CONTROL_TB/DUT/C2/reg_array_confregs[3]} -radix hexadecimal} {{/CONF_CONTROL_TB/DUT/C2/reg_array_confregs[2]} -radix hexadecimal} {{/CONF_CONTROL_TB/DUT/C2/reg_array_confregs[1]} -radix hexadecimal} {{/CONF_CONTROL_TB/DUT/C2/reg_array_confregs[0]} -radix hexadecimal}} -subitemconfig {{/CONF_CONTROL_TB/DUT/C2/reg_array_confregs[10]} {-height 15 -radix hexadecimal} {/CONF_CONTROL_TB/DUT/C2/reg_array_confregs[9]} {-height 15 -radix hexadecimal} {/CONF_CONTROL_TB/DUT/C2/reg_array_confregs[8]} {-height 15 -radix hexadecimal} {/CONF_CONTROL_TB/DUT/C2/reg_array_confregs[7]} {-height 15 -radix hexadecimal} {/CONF_CONTROL_TB/DUT/C2/reg_array_confregs[6]} {-height 15 -radix hexadecimal} {/CONF_CONTROL_TB/DUT/C2/reg_array_confregs[5]} {-height 15 -radix hexadecimal} {/CONF_CONTROL_TB/DUT/C2/reg_array_confregs[4]} {-height 15 -radix hexadecimal} {/CONF_CONTROL_TB/DUT/C2/reg_array_confregs[3]} {-height 15 -radix hexadecimal} {/CONF_CONTROL_TB/DUT/C2/reg_array_confregs[2]} {-height 15 -radix hexadecimal} {/CONF_CONTROL_TB/DUT/C2/reg_array_confregs[1]} {-height 15 -radix hexadecimal} {/CONF_CONTROL_TB/DUT/C2/reg_array_confregs[0]} {-height 15 -radix hexadecimal}} /CONF_CONTROL_TB/DUT/C2/reg_array_confregs
add wave -noupdate -radix hexadecimal /CONF_CONTROL_TB/DUT/C2/reg_array_txregs
add wave -noupdate -radix hexadecimal -childformat {{{/CONF_CONTROL_TB/DUT/C2/reg_array_out[10]} -radix hexadecimal} {{/CONF_CONTROL_TB/DUT/C2/reg_array_out[9]} -radix hexadecimal} {{/CONF_CONTROL_TB/DUT/C2/reg_array_out[8]} -radix hexadecimal} {{/CONF_CONTROL_TB/DUT/C2/reg_array_out[7]} -radix hexadecimal} {{/CONF_CONTROL_TB/DUT/C2/reg_array_out[6]} -radix hexadecimal} {{/CONF_CONTROL_TB/DUT/C2/reg_array_out[5]} -radix hexadecimal} {{/CONF_CONTROL_TB/DUT/C2/reg_array_out[4]} -radix hexadecimal} {{/CONF_CONTROL_TB/DUT/C2/reg_array_out[3]} -radix hexadecimal} {{/CONF_CONTROL_TB/DUT/C2/reg_array_out[2]} -radix hexadecimal} {{/CONF_CONTROL_TB/DUT/C2/reg_array_out[1]} -radix hexadecimal} {{/CONF_CONTROL_TB/DUT/C2/reg_array_out[0]} -radix hexadecimal}} -expand -subitemconfig {{/CONF_CONTROL_TB/DUT/C2/reg_array_out[10]} {-radix hexadecimal} {/CONF_CONTROL_TB/DUT/C2/reg_array_out[9]} {-radix hexadecimal} {/CONF_CONTROL_TB/DUT/C2/reg_array_out[8]} {-radix hexadecimal} {/CONF_CONTROL_TB/DUT/C2/reg_array_out[7]} {-radix hexadecimal} {/CONF_CONTROL_TB/DUT/C2/reg_array_out[6]} {-radix hexadecimal} {/CONF_CONTROL_TB/DUT/C2/reg_array_out[5]} {-radix hexadecimal} {/CONF_CONTROL_TB/DUT/C2/reg_array_out[4]} {-radix hexadecimal} {/CONF_CONTROL_TB/DUT/C2/reg_array_out[3]} {-radix hexadecimal} {/CONF_CONTROL_TB/DUT/C2/reg_array_out[2]} {-radix hexadecimal} {/CONF_CONTROL_TB/DUT/C2/reg_array_out[1]} {-radix hexadecimal} {/CONF_CONTROL_TB/DUT/C2/reg_array_out[0]} {-radix hexadecimal}} /CONF_CONTROL_TB/DUT/C2/reg_array_out
TreeUpdate [SetDefaultTree]
WaveRestoreCursors {{Cursor 1} {3555 ps} 0}
quietly wave cursor active 1
configure wave -namecolwidth 324
configure wave -valuecolwidth 47
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
WaveRestoreZoom {3054 ps} {3844 ps}
