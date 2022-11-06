onerror {resume}
quietly WaveActivateNextPane {} 0
add wave -noupdate /TB_R_INT/clk
add wave -noupdate /TB_R_INT/rst
add wave -noupdate /TB_R_INT/val_in
add wave -noupdate /TB_R_INT/val_out
add wave -noupdate -expand -group {Data In} -format Analog-Step -height 74 -max 53230.000000000007 -min -74230.0 /TB_R_INT/data_in
add wave -noupdate -expand -group {Data Out} -color Orange -format Analog-Step -height 74 -max 53230.0 -min -74230.0 /TB_R_INT/data_out_F
add wave -noupdate -expand -group {Data Out} -color Orange -format Analog-Step -height 74 -max 53230.0 -min -74230.0 /TB_R_INT/data_out_M
add wave -noupdate -expand -group {Signals Test} -color {Dark Orchid} /TB_R_INT/sample_cnt
add wave -noupdate -expand -group {Signals Test} -color {Dark Orchid} /TB_R_INT/error_cnt
TreeUpdate [SetDefaultTree]
WaveRestoreCursors {{Cursor 1} {0 ps} 0}
quietly wave cursor active 1
configure wave -namecolwidth 256
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
WaveRestoreZoom {0 ps} {1050199500 ps}
