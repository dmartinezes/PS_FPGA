onerror {resume}
quietly WaveActivateNextPane {} 0
add wave -noupdate /TB_DP_MOD/clk
add wave -noupdate /TB_DP_MOD/rst
add wave -noupdate /TB_DP_MOD/load_data
add wave -noupdate -format Analog-Step -height 74 -max 32767.0 -min -32767.0 -radix sfixed /TB_DP_MOD/i_data
add wave -noupdate -radix sfixed /TB_DP_MOD/o_data_M
add wave -noupdate -radix sfixed /TB_DP_MOD/o_data_F
add wave -noupdate /TB_DP_MOD/error_cnt
add wave -noupdate /TB_DP_MOD/sample_cnt
TreeUpdate [SetDefaultTree]
WaveRestoreCursors {{Cursor 1} {355673 ps} 0}
quietly wave cursor active 1
configure wave -namecolwidth 289
configure wave -valuecolwidth 127
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
WaveRestoreZoom {0 ps} {7192500 ps}
