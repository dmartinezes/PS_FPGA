onerror {resume}
quietly WaveActivateNextPane {} 0
add wave -noupdate /TB_INT/clk
add wave -noupdate /TB_INT/rst
add wave -noupdate /TB_INT/load_data
add wave -noupdate /TB_INT/val_in
add wave -noupdate /TB_INT/val_out
add wave -noupdate -format Analog-Step -height 74 -max 43068.000000000007 -min -43067.0 /TB_INT/data_in
add wave -noupdate -expand -group {Data Out} -color Orange -format Analog-Step -height 74 -max 62328000.0 -min -77038000.0 /TB_INT/data_out_F
add wave -noupdate -expand -group {Data Out} -color Orange -format Analog-Step -height 74 -max 62328000.0 -min -77038000.0 /TB_INT/data_out_M
add wave -noupdate -expand -group {Signals Test} -color {Dark Orchid} /TB_INT/sample_cnt
add wave -noupdate -expand -group {Signals Test} -color {Dark Orchid} /TB_INT/error_cnt
TreeUpdate [SetDefaultTree]
WaveRestoreCursors {{Cursor 1} {20143153 ps} 0}
quietly wave cursor active 1
configure wave -namecolwidth 237
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
WaveRestoreZoom {0 ps} {1050210 ns}
