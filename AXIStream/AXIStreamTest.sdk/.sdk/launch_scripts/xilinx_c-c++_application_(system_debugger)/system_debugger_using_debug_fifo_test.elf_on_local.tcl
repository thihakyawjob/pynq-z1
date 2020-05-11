connect -url tcp:127.0.0.1:3121
set bp_30_46_0 [bpadd -target-id all -ct-input {0} -ct-output {24 25 26 27}]
set bp_30_46_1 [bpadd -target-id all -ct-input {24 25 26 27} -ct-output {0}]
source /home/twinborn/Data/FPGA/PYNQ/AXIStream/AXIStreamTest.sdk/system_top_wrapper_hw_platform_0/ps7_init.tcl
targets -set -nocase -filter {name =~"APU*" && jtag_cable_name =~ "Xilinx PYNQ-Z1 003017AC8218A"} -index 0
loadhw -hw /home/twinborn/Data/FPGA/PYNQ/AXIStream/AXIStreamTest.sdk/system_top_wrapper_hw_platform_0/system.hdf -mem-ranges [list {0x40000000 0xbfffffff}]
configparams force-mem-access 1
targets -set -nocase -filter {name =~"APU*" && jtag_cable_name =~ "Xilinx PYNQ-Z1 003017AC8218A"} -index 0
stop
ps7_init
ps7_post_config
targets -set -nocase -filter {name =~ "ARM*#0" && jtag_cable_name =~ "Xilinx PYNQ-Z1 003017AC8218A"} -index 0
rst -processor
targets -set -nocase -filter {name =~ "ARM*#0" && jtag_cable_name =~ "Xilinx PYNQ-Z1 003017AC8218A"} -index 0
dow /home/twinborn/Data/FPGA/PYNQ/AXIStream/AXIStreamTest.sdk/fifo_test/Debug/fifo_test.elf
configparams force-mem-access 0
bpadd -addr &main
