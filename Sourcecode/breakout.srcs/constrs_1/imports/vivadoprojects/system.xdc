set_property -dict { PACKAGE_PIN H4  IOSTANDARD LVCMOS33 } [get_ports { clk }]; 
#create_clock -name sys_clk_pin -period 10.00 -waveform {0 5} [get_ports { clk }];

#GPIO out

set_property PACKAGE_PIN F4 [get_ports {TMDS_Tx_Clk_N}]
set_property PACKAGE_PIN G4 [get_ports {TMDS_Tx_Clk_P}]
set_property PACKAGE_PIN F1 [get_ports {TMDS_Tx_Data_N[0]}]
set_property PACKAGE_PIN G1 [get_ports {TMDS_Tx_Data_P[0]}]
set_property PACKAGE_PIN D2 [get_ports {TMDS_Tx_Data_N[1]}]
set_property PACKAGE_PIN E2 [get_ports {TMDS_Tx_Data_P[1]}]
set_property PACKAGE_PIN C1 [get_ports {TMDS_Tx_Data_N[2]}]
set_property PACKAGE_PIN D1 [get_ports {TMDS_Tx_Data_P[2]}]

set_property IOSTANDARD TMDS_33 [get_ports {TMDS_Tx_Clk_N}]
set_property IOSTANDARD TMDS_33 [get_ports {TMDS_Tx_Clk_P}]
set_property IOSTANDARD TMDS_33 [get_ports {TMDS_Tx_Data_N[0]}]
set_property IOSTANDARD TMDS_33 [get_ports {TMDS_Tx_Data_P[0]}]
set_property IOSTANDARD TMDS_33 [get_ports {TMDS_Tx_Data_N[1]}]
set_property IOSTANDARD TMDS_33 [get_ports {TMDS_Tx_Data_P[1]}]
set_property IOSTANDARD TMDS_33 [get_ports {TMDS_Tx_Data_N[2]}]
set_property IOSTANDARD TMDS_33 [get_ports {TMDS_Tx_Data_P[2]}]

set_property PULLDOWN true [get_ports TMDS_Tx_Clk_N]
set_property PULLDOWN true [get_ports TMDS_Tx_Clk_P]
set_property PULLDOWN true [get_ports {TMDS_Tx_Data_N[0]}]
set_property PULLDOWN true [get_ports {TMDS_Tx_Data_P[0]}]
set_property PULLDOWN true [get_ports {TMDS_Tx_Data_N[1]}]
set_property PULLDOWN true [get_ports {TMDS_Tx_Data_P[1]}]
set_property PULLDOWN true [get_ports {TMDS_Tx_Data_N[2]}]
set_property PULLDOWN true [get_ports {TMDS_Tx_Data_P[2]}]

#GPIO in
set_property PACKAGE_PIN C3 [get_ports key_l]
set_property PACKAGE_PIN M4 [get_ports key_r]
set_property PACKAGE_PIN D14 [get_ports launch]

set_property IOSTANDARD LVCMOS33 [get_ports key_l]
set_property IOSTANDARD LVCMOS33 [get_ports key_r]
set_property IOSTANDARD LVCMOS33 [get_ports launch]

