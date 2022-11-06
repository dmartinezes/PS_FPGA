onerror {resume}
quietly WaveActivateNextPane {} 0
add wave -noupdate /REGS_CONF_TB/PER
add wave -noupdate -expand -group Inputs -color Cyan /REGS_CONF_TB/clk
add wave -noupdate -expand -group Inputs -color Cyan /REGS_CONF_TB/rst
add wave -noupdate -expand -group Inputs -color Cyan /REGS_CONF_TB/rxdw
add wave -noupdate -expand -group Inputs -color Cyan /REGS_CONF_TB/shift_rxregs
add wave -noupdate -expand -group Inputs -color Cyan /REGS_CONF_TB/load_confregs
add wave -noupdate -expand -group Inputs -color Cyan /REGS_CONF_TB/load_txregs
add wave -noupdate -expand -group Inputs -color Cyan /REGS_CONF_TB/shift_txregs
add wave -noupdate -expand -group Outputs -color Orange /REGS_CONF_TB/txdw
add wave -noupdate -expand -group Outputs -color Orange /REGS_CONF_TB/r_control
add wave -noupdate -expand -group Outputs -color Orange /REGS_CONF_TB/r_frec_mod
add wave -noupdate -expand -group Outputs -color Orange /REGS_CONF_TB/r_frec_por
add wave -noupdate -expand -group Outputs -color Orange /REGS_CONF_TB/r_im_am
add wave -noupdate -expand -group Outputs -color Orange /REGS_CONF_TB/r_im_fm
TreeUpdate [SetDefaultTree]
WaveRestoreCursors {{Cursor 1} {0 ps} 0}
quietly wave cursor active 0
configure wave -namecolwidth 261
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
WaveRestoreZoom {0 ps} {3816 ps}
