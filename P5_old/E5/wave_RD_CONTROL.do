onerror {resume}
quietly WaveActivateNextPane {} 0
add wave -noupdate /RD_CONTROL_TB/clk
add wave -noupdate /RD_CONTROL_TB/rst
add wave -noupdate -expand -group Inputs -color Cyan /RD_CONTROL_TB/txbusy
add wave -noupdate -expand -group Inputs -color Cyan /RD_CONTROL_TB/start_rd
add wave -noupdate -expand -group Outputs -color Orange /RD_CONTROL_TB/txena
add wave -noupdate -expand -group Outputs -color Orange /RD_CONTROL_TB/load_txregs
add wave -noupdate -expand -group Outputs -color Orange /RD_CONTROL_TB/shift_txregs
add wave -noupdate -expand -group Outputs -color Orange /RD_CONTROL_TB/done_rd
add wave -noupdate -expand -group Outputs -color Orange -radix unsigned /RD_CONTROL_TB/rd_leds
add wave -noupdate -radix unsigned /RD_CONTROL_TB/dut1/count
TreeUpdate [SetDefaultTree]
WaveRestoreCursors {{Cursor 1} {2810000 ps} 0}
quietly wave cursor active 1
configure wave -namecolwidth 244
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
WaveRestoreZoom {0 ps} {10457818 ps}
