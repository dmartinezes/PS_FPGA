onerror {resume}
quietly WaveActivateNextPane {} 0
add wave -noupdate /TB_DDS_test/P
add wave -noupdate /TB_DDS_test/ena_ac
add wave -noupdate -format Analog-Step -height 74 -max 32766.999999999993 -min -32768.0 /TB_DDS_test/ramp_wave
add wave -noupdate /TB_DDS_test/rst_ac
add wave -noupdate -format Analog-Step -height 74 -max 1.0 /TB_DDS_test/sqr_wave
TreeUpdate [SetDefaultTree]
WaveRestoreCursors {{Cursor 1} {0 ps} 0}
quietly wave cursor active 0
configure wave -namecolwidth 150
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
WaveRestoreZoom {14015515441 ps} {14018036585 ps}
