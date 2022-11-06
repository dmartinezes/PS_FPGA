onerror {resume}
quietly WaveActivateNextPane {} 0
add wave -noupdate /TB_CIC_pc/clk
add wave -noupdate /TB_CIC_pc/rst
add wave -noupdate /TB_CIC_pc/load_data
add wave -noupdate /TB_CIC_pc/val_in
add wave -noupdate /TB_CIC_pc/val_out
add wave -noupdate -format Analog-Step -height 74 -max 31163.000000000004 -min -31164.0 /TB_CIC_pc/data_in
add wave -noupdate -expand -group {Data Out Comparison} -color Orange -format Analog-Step -height 74 -max 107425000000.0 -min -107429000000.0 /TB_CIC_pc/data_out_F
add wave -noupdate -expand -group {Data Out Comparison} -color Orange -format Analog-Step -height 74 -max 107425000000.0 -min -107429000000.0 -radix sfixed /TB_CIC_pc/data_out_M
add wave -noupdate -expand -group {Signals Test} -color {Dark Orchid} /TB_CIC_pc/sample_cnt
add wave -noupdate -expand -group {Signals Test} -color {Dark Orchid} /TB_CIC_pc/error_cnt
add wave -noupdate -group {Waveforms COMB blocks} -format Analog-Step -height 74 -max 31164.0 -min -38519.0 /TB_CIC_pc/ri1/data_comb1
add wave -noupdate -group {Waveforms COMB blocks} -format Analog-Step -height 74 -max 43068.000000000007 -min -43067.0 /TB_CIC_pc/ri1/data_comb2
add wave -noupdate -group {Waveforms COMB blocks} -format Analog-Step -height 74 -max 53230.000000000007 -min -74230.0 /TB_CIC_pc/ri1/data_comb3
add wave -noupdate -group {Validation Signals} -color Blue /TB_CIC_pc/ri1/val_comb1
add wave -noupdate -group {Validation Signals} -color Blue /TB_CIC_pc/ri1/val_comb2
add wave -noupdate -group {Validation Signals} -color Blue /TB_CIC_pc/ri1/val_comb3
add wave -noupdate -group {Validation Signals} -color Blue /TB_CIC_pc/ri1/val_int1
add wave -noupdate -group {Validation Signals} -color Blue /TB_CIC_pc/ri1/val_int2
add wave -noupdate -group {Validation Signals} -color Blue /TB_CIC_pc/ri1/val_int3
add wave -noupdate -group {Waveforms INT blocks} -format Analog-Step -height 74 -max 53230.000000000007 -min -74230.0 /TB_CIC_pc/ri1/data_int1
add wave -noupdate -group {Waveforms INT blocks} -format Analog-Step -height 74 -max 43068.000000000007 -min -43067.0 /TB_CIC_pc/ri1/data_int2
add wave -noupdate -group {Waveforms INT blocks} -format Analog-Step -height 74 -max 62328000.000000007 -min -77038000.0 /TB_CIC_pc/ri1/data_int3
add wave -noupdate -group {Waveforms INT blocks} -format Analog-Step -height 74 -max 107424689924.0 -min -107428537296.0 /TB_CIC_pc/ri1/o_data
TreeUpdate [SetDefaultTree]
WaveRestoreCursors {{Cursor 1} {20183918 ps} 0}
quietly wave cursor active 1
configure wave -namecolwidth 247
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
