## create clocks ##

## write clock ##
create_clock -period 10.000 -name wr_clk [get_ports s_axis_clk]


## read clock ##
create_clock -period 40.000 -name rd_clk [get_ports m_axis_clk]


## specify asynchronous registers ##
set_property ASYNC_REG true [get_cells -hierarchical *sync*]

#set_property IOSTANDARD LVCMOS18 [get_ports {m_axis_tdata[3]}]
#set_property IOSTANDARD LVCMOS18 [get_ports {m_axis_tdata[2]}]
#set_property IOSTANDARD LVCMOS18 [get_ports {m_axis_tdata[1]}]
#set_property IOSTANDARD LVCMOS18 [get_ports {m_axis_tdata[0]}]
#set_property IOSTANDARD LVCMOS18 [get_ports {s_axis_tdata[3]}]
#set_property IOSTANDARD LVCMOS18 [get_ports {s_axis_tdata[2]}]
#set_property IOSTANDARD LVCMOS18 [get_ports {s_axis_tdata[1]}]
#set_property IOSTANDARD LVCMOS18 [get_ports {s_axis_tdata[0]}]
#set_property PACKAGE_PIN A20 [get_ports {m_axis_tdata[3]}]
#set_property PACKAGE_PIN A19 [get_ports {m_axis_tdata[2]}]
#set_property PACKAGE_PIN A18 [get_ports {m_axis_tdata[1]}]
#set_property PACKAGE_PIN A16 [get_ports {m_axis_tdata[0]}]
#set_property PACKAGE_PIN A15 [get_ports {s_axis_tdata[3]}]
#set_property PACKAGE_PIN A14 [get_ports {s_axis_tdata[2]}]
#set_property PACKAGE_PIN A13 [get_ports {s_axis_tdata[1]}]
#set_property PACKAGE_PIN A10 [get_ports {s_axis_tdata[0]}]
#set_property IOSTANDARD LVCMOS18 [get_ports m_axis_rst_n]
#set_property IOSTANDARD LVCMOS18 [get_ports m_axis_clk]
#set_property IOSTANDARD LVCMOS18 [get_ports m_axis_tready]
#set_property IOSTANDARD LVCMOS18 [get_ports m_axis_tvalid]
#set_property IOSTANDARD LVCMOS18 [get_ports s_axis_clk]
#set_property IOSTANDARD LVCMOS18 [get_ports s_axis_rst_n]
#set_property IOSTANDARD LVCMOS18 [get_ports s_axis_tready]
#set_property IOSTANDARD LVCMOS18 [get_ports s_axis_tvalid]
#set_property PACKAGE_PIN Y22 [get_ports m_axis_clk]
#set_property PACKAGE_PIN Y21 [get_ports m_axis_rst_n]
#set_property PACKAGE_PIN Y19 [get_ports m_axis_tready]
#set_property PACKAGE_PIN Y18 [get_ports m_axis_tvalid]
#set_property PACKAGE_PIN Y9 [get_ports s_axis_clk]
#set_property PACKAGE_PIN Y8 [get_ports s_axis_rst_n]
#set_property PACKAGE_PIN Y6 [get_ports s_axis_tready]
#set_property PACKAGE_PIN W22 [get_ports s_axis_tvalid]
