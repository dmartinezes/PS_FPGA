onerror {resume}
quietly WaveActivateNextPane {} 0
add wave -noupdate /TB_COMB/clk
add wave -noupdate /TB_COMB/rst
add wave -noupdate /TB_COMB/val_in
add wave -noupdate /TB_COMB/val_out
add wave -noupdate -format Analog-Step -height 74 -max 31163.000000000004 -min -31164.0 /TB_COMB/data_in
add wave -noupdate -expand -group {Data Out} -color Orange -format Analog-Step -height 74 -max 31164.0 -min -38519.0 -radix sfixed /TB_COMB/data_out_F
add wave -noupdate -expand -group {Data Out} -color Orange -format Analog-Step -height 74 -max 31164.0 -min -38519.0 -radix sfixed /TB_COMB/data_out_M
add wave -noupdate -expand -group {Signals Test} -color {Dark Orchid} /TB_COMB/sample_cnt
add wave -noupdate -expand -group {Signals Test} -color {Dark Orchid} /TB_COMB/error_cnt
add wave -noupdate -expand -group {Signals Test} -color {Dark Orchid} /TB_COMB/load_data
TreeUpdate [SetDefaultTree]
WaveRestoreCursors {{Cursor 1} {91508 ps} 0}
quietly wave cursor active 1
configure wave -namecolwidth 270
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
WaveRestoreZoom {0 ps} {735 ns}
