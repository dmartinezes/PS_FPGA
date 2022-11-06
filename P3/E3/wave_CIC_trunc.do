onerror {resume}
quietly WaveActivateNextPane {} 0
add wave -noupdate /TB_CIC/clk
add wave -noupdate /TB_CIC/rst
add wave -noupdate /TB_CIC/val_in
add wave -noupdate /TB_CIC/val_out
add wave -noupdate -expand -group {Data Out Comparison} -color Orange /TB_CIC/data_out_F
add wave -noupdate -expand -group {Data Out Comparison} -color Orange /TB_CIC/data_out_M
add wave -noupdate -expand -group {Signals Test} -color {Dark Orchid} /TB_CIC/sample_cnt
add wave -noupdate -expand -group {Signals Test} -color {Dark Orchid} /TB_CIC/error_cnt
TreeUpdate [SetDefaultTree]
WaveRestoreCursors {{Cursor 1} {20183918 ps} 0}
quietly wave cursor active 1
configure wave -namecolwidth 282
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
WaveRestoreZoom {0 ps} {1026096561 ps}
