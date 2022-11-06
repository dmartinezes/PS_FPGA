onerror {resume}
quietly WaveActivateNextPane {} 0
add wave -noupdate /MAIN_CONTROL_TB/clk
add wave -noupdate /MAIN_CONTROL_TB/rst
add wave -noupdate -expand -group Inputs -color Cyan /MAIN_CONTROL_TB/rxrdy
add wave -noupdate -expand -group Inputs -color Cyan -radix binary /MAIN_CONTROL_TB/rxdw
add wave -noupdate -expand -group Inputs -color Cyan /MAIN_CONTROL_TB/done_wr
add wave -noupdate -expand -group Inputs -color Cyan /MAIN_CONTROL_TB/done_rd
add wave -noupdate -expand -group Outputs -color Orange /MAIN_CONTROL_TB/start_wr
add wave -noupdate -expand -group Outputs -color Orange /MAIN_CONTROL_TB/start_rd
add wave -noupdate -expand -group Outputs -color Orange -radix decimal /MAIN_CONTROL_TB/sleds
TreeUpdate [SetDefaultTree]
WaveRestoreCursors {{Cursor 1} {321000 ps} 0}
quietly wave cursor active 1
configure wave -namecolwidth 220
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
WaveRestoreZoom {0 ps} {6170779 ps}
