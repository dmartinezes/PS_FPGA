onerror {resume}
quietly WaveActivateNextPane {} 0
add wave -noupdate /WR_CONTROL_TB/PER
add wave -noupdate /WR_CONTROL_TB/clk
add wave -noupdate /WR_CONTROL_TB/rst
add wave -noupdate -expand -group Inputs -color Cyan /WR_CONTROL_TB/rxrdy
add wave -noupdate -expand -group Inputs -color Cyan /WR_CONTROL_TB/start_wr
add wave -noupdate -expand -group Outputs -color Orange /WR_CONTROL_TB/shift_rxregs
add wave -noupdate -expand -group Outputs -color Orange /WR_CONTROL_TB/load_confregs
add wave -noupdate -expand -group Outputs -color Orange /WR_CONTROL_TB/done_wr
add wave -noupdate -expand -group Outputs -color Orange /WR_CONTROL_TB/wr_leds
TreeUpdate [SetDefaultTree]
WaveRestoreCursors {{Cursor 1} {0 ps} 0}
quietly wave cursor active 0
configure wave -namecolwidth 310
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
WaveRestoreZoom {0 ps} {901 ps}
