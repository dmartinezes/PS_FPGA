onerror {resume}
quietly WaveActivateNextPane {} 0
add wave -noupdate /TB_SEC_FILTER/clk
add wave -noupdate /TB_SEC_FILTER/rst
add wave -noupdate /TB_SEC_FILTER/load_data
add wave -noupdate /TB_SEC_FILTER/val_in
add wave -noupdate /TB_SEC_FILTER/val_out
add wave -noupdate -expand -group DUT -expand -group DUT -color Cyan -format Analog-Step -height 74 -max 31163.000000000004 -min -31164.0 /TB_SEC_FILTER/din
add wave -noupdate -expand -group DUT -expand -group Outputs -color Orange -format Analog-Step -height 74 -max 88466.0 -min -82599.0 /TB_SEC_FILTER/dout_F
add wave -noupdate -expand -group DUT -expand -group Outputs -color Orange -format Analog-Step -height 74 -max 88466.0 -min -82599.0 /TB_SEC_FILTER/dout_M
add wave -noupdate -expand -group {Signals Test} -color {Dark Orchid} /TB_SEC_FILTER/sample_cnt
add wave -noupdate -expand -group {Signals Test} -color {Dark Orchid} /TB_SEC_FILTER/error_cnt
add wave -noupdate -expand -group {REG MUX} -color Cyan -radix unsigned /TB_SEC_FILTER/DUT/regMux/sel
add wave -noupdate -expand -group {REG MUX} -color Cyan /TB_SEC_FILTER/DUT/regMux/din
add wave -noupdate -expand -group {REG MUX} /TB_SEC_FILTER/DUT/regMux/dout
add wave -noupdate -expand -group {REG MUX} -childformat {{{/TB_SEC_FILTER/DUT/regMux/reg_array[0]} -radix decimal}} -subitemconfig {{/TB_SEC_FILTER/DUT/regMux/reg_array[0]} {-height 15 -radix decimal}} /TB_SEC_FILTER/DUT/regMux/reg_array
add wave -noupdate -expand -group {MULT ACC} -color Cyan /TB_SEC_FILTER/DUT/multAcc/din
add wave -noupdate -expand -group {MULT ACC} -color Cyan /TB_SEC_FILTER/DUT/multAcc/coef
add wave -noupdate -expand -group {MULT ACC} -color Orange /TB_SEC_FILTER/DUT/multAcc/dout
add wave -noupdate -expand -group {MULT ACC} /TB_SEC_FILTER/DUT/multAcc/rst
add wave -noupdate -expand -group {MULT ACC} /TB_SEC_FILTER/DUT/multAcc/ce
add wave -noupdate -expand -group CONTROL -color Orange -radix unsigned /TB_SEC_FILTER/DUT/dut1/addr
add wave -noupdate -expand -group CONTROL -color Orange /TB_SEC_FILTER/DUT/dut1/ce_Reg
add wave -noupdate -expand -group CONTROL -color Orange /TB_SEC_FILTER/DUT/dut1/rst_Acc
add wave -noupdate -expand -group CONTROL -color Orange /TB_SEC_FILTER/DUT/dut1/ce_Acc
add wave -noupdate -expand -group CONTROL -radix unsigned /TB_SEC_FILTER/DUT/dut1/state_reg
add wave -noupdate -expand -group CONTROL -radix unsigned /TB_SEC_FILTER/DUT/dut1/state
add wave -noupdate -expand -group CONTROL -radix unsigned /TB_SEC_FILTER/DUT/dut1/next_state
TreeUpdate [SetDefaultTree]
WaveRestoreCursors {{Cursor 1} {40120000 ps} 0}
quietly wave cursor active 1
configure wave -namecolwidth 295
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
WaveRestoreZoom {40063885 ps} {40320259 ps}
