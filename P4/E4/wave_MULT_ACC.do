onerror {resume}
quietly WaveActivateNextPane {} 0
add wave -noupdate /TB_MULT_ACC/clk
add wave -noupdate /TB_MULT_ACC/load_data
add wave -noupdate /TB_MULT_ACC/rst
add wave -noupdate /TB_MULT_ACC/val_in
add wave -noupdate /TB_MULT_ACC/count
add wave -noupdate -expand -group {MULT_ACC signals } -expand -group {MULT_ACC signals } -color Cyan /TB_MULT_ACC/din
add wave -noupdate -expand -group {MULT_ACC signals } -expand -group {MULT_ACC signals } -color Cyan /TB_MULT_ACC/coef
add wave -noupdate -expand -group {MULT_ACC signals } -expand -group Output -color Orange /TB_MULT_ACC/dout
TreeUpdate [SetDefaultTree]
WaveRestoreCursors {{Cursor 1} {117461 ps} 0}
quietly wave cursor active 1
configure wave -namecolwidth 308
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
WaveRestoreZoom {31925 ps} {366749 ps}
