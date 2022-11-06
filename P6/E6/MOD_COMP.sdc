create_clock -name clock_m -period 20 [get_ports {CLOCK_50}]

derive_pll_clocks
derive_clock_uncertainty

#**************************************************************
# Set Input Delay
#**************************************************************
set_input_delay -clock { pll_inst1|altpll_component|auto_generated|pll1|clk[0] } 3 [get_ports {ADC_D* }]


#**************************************************************
# Set Output Delay
#**************************************************************
set_output_delay -clock { pll_inst1|altpll_component|auto_generated|pll1|clk[0] } 3 [get_ports {DAC_D*}]

#**************************************************************
# Set Maximum Delay
#**************************************************************
set_max_delay -to [get_ports {DAC_CLK*}] 5
set_max_delay -to [get_ports {ADC_CLK*}] 5


#**************************************************************
# Set Minimum Delay
#**************************************************************
set_min_delay -to [get_ports {DAC_CLK*}] 1
set_min_delay -to [get_ports {ADC_CLK*}] 1
