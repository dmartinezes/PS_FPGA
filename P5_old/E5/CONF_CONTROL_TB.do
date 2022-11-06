onerror {resume}
quietly WaveActivateNextPane {} 0
add wave -noupdate /CONF_CONTROL_TB/clk
add wave -noupdate /CONF_CONTROL_TB/rst
add wave -noupdate -divider {TX-RX CONTROL}
add wave -noupdate -radix hexadecimal /CONF_CONTROL_TB/rxdw
add wave -noupdate /CONF_CONTROL_TB/rxrdy
add wave -noupdate /CONF_CONTROL_TB/txbusy
add wave -noupdate -radix hexadecimal /CONF_CONTROL_TB/txdw
add wave -noupdate /CONF_CONTROL_TB/txena
add wave -noupdate -divider {REGISTROS CONF}
add wave -noupdate -radix hexadecimal /CONF_CONTROL_TB/r_frec_mod
add wave -noupdate -radix hexadecimal /CONF_CONTROL_TB/r_frec_por
add wave -noupdate -radix hexadecimal /CONF_CONTROL_TB/r_im_am
add wave -noupdate -radix hexadecimal /CONF_CONTROL_TB/r_im_fm
add wave -noupdate -radix hexadecimal /CONF_CONTROL_TB/r_control
TreeUpdate [SetDefaultTree]
WaveRestoreCursors {{Cursor 1} {0 ps} 0}
quietly wave cursor active 0
configure wave -namecolwidth 225
configure wave -valuecolwidth 47
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
WaveRestoreZoom {0 ps} {5327 ps}
