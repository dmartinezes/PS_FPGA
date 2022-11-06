onerror {resume}
quietly WaveActivateNextPane {} 0
add wave -noupdate /TB_REG_MUX/clk
add wave -noupdate -expand -group Control /TB_REG_MUX/rst
add wave -noupdate -expand -group Control /TB_REG_MUX/val_in
add wave -noupdate -expand -group {REG MUX Signals} -expand -group {REG MUX Signals} -color Cyan /TB_REG_MUX/sel_reg1
add wave -noupdate -expand -group {REG MUX Signals} -expand -group {REG MUX Signals} -color Cyan /TB_REG_MUX/dut1/din
add wave -noupdate -expand -group {REG MUX Signals} -expand -group Outputs -color Orange -radix decimal /TB_REG_MUX/dout
add wave -noupdate -expand -group {REG MUX Signals} -expand -group Outputs -color Orange -subitemconfig {{/TB_REG_MUX/dut1/reg_array[16]} {-color Orange} {/TB_REG_MUX/dut1/reg_array[15]} {-color Orange} {/TB_REG_MUX/dut1/reg_array[14]} {-color Orange} {/TB_REG_MUX/dut1/reg_array[13]} {-color Orange} {/TB_REG_MUX/dut1/reg_array[12]} {-color Orange} {/TB_REG_MUX/dut1/reg_array[11]} {-color Orange} {/TB_REG_MUX/dut1/reg_array[10]} {-color Orange} {/TB_REG_MUX/dut1/reg_array[9]} {-color Orange} {/TB_REG_MUX/dut1/reg_array[8]} {-color Orange} {/TB_REG_MUX/dut1/reg_array[7]} {-color Orange} {/TB_REG_MUX/dut1/reg_array[6]} {-color Orange} {/TB_REG_MUX/dut1/reg_array[5]} {-color Orange} {/TB_REG_MUX/dut1/reg_array[4]} {-color Orange} {/TB_REG_MUX/dut1/reg_array[3]} {-color Orange} {/TB_REG_MUX/dut1/reg_array[2]} {-color Orange} {/TB_REG_MUX/dut1/reg_array[1]} {-color Orange} {/TB_REG_MUX/dut1/reg_array[0]} {-color Orange}} /TB_REG_MUX/dut1/reg_array
TreeUpdate [SetDefaultTree]
WaveRestoreCursors {{Cursor 1} {173189 ps} 0}
quietly wave cursor active 1
configure wave -namecolwidth 226
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
WaveRestoreZoom {0 ps} {5355 ns}
