onerror {resume}
quietly WaveActivateNextPane {} 0
add wave -noupdate /TB_CONTROL/clk
add wave -noupdate /TB_CONTROL/rst
add wave -noupdate /TB_CONTROL/val_in
add wave -noupdate -expand -group Outputs -color Goldenrod -radix unsigned /TB_CONTROL/addr
add wave -noupdate -expand -group Outputs -color Goldenrod -radix binary /TB_CONTROL/ce_Acc
add wave -noupdate -expand -group Outputs -color Goldenrod -radix binary /TB_CONTROL/rst_Acc
add wave -noupdate -expand -group Outputs -color Goldenrod -radix binary /TB_CONTROL/ce_Reg
add wave -noupdate /TB_CONTROL/dut1/state_reg
add wave -noupdate /TB_CONTROL/dut1/state
add wave -noupdate /TB_CONTROL/dut1/next_state
TreeUpdate [SetDefaultTree]
WaveRestoreCursors {{Cursor 1} {282867 ps} 0}
quietly wave cursor active 1
configure wave -namecolwidth 243
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
WaveRestoreZoom {4851964 ps} {5114108 ps}
