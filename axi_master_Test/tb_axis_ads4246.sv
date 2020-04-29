`timescale 1ns / 1ps
//////////////////////////////////////////////////////////////////////////////////
// Company: 
// Engineer: 
// 
// Create Date: 28.04.2020 10:27:52
// Design Name: 
// Module Name: tb_axis_ads4246
// Project Name: 
// Target Devices: 
// Tool Versions: 
// Description: 
// 
// Dependencies: 
// 
// Revision:
// Revision 0.01 - File Created
// Additional Comments:
// 
//////////////////////////////////////////////////////////////////////////////////


module tb_axis_ads4246(

    );
    
default clocking cb @(posedge aclk);
endclocking

bit aclk, areset_n, adc_ready;

logic [31:0] tstrb;

logic tready;
 
logic tvalid, tlast;
logic [31:0] tdata;
logic [31:0] data;

axi_ads4246_v1_0_M_AXIS inst_axis_m (
                    .M_AXIS_ACLK(aclk),
                    .M_AXIS_ARESETN(areset_n), 
                    
                    .M_AXIS_TVALID(tvalid),
                    .M_AXIS_TDATA(tdata),
                    .M_AXIS_TSTRB (tstrb),
                    .M_AXIS_TLAST(tlast),
                    
					.M_AXIS_TREADY(tready),     // TREADY indicates that the slave can accept a transfer in the current cycle.              
                    .M_ADC_Data(data),          // Data to transmit
                    .M_ADC_READY(adc_ready)              //ADC Data is ready to read
					);
					
initial 
 forever #2 aclk++;

initial
begin
    areset_n <= 0;
    ##4 areset_n <= 1;
end

initial
begin
##6    adc_ready = 1;
##1    adc_ready = 0;
##12    adc_ready = 1;
##1    adc_ready = 0;
end

initial
begin
    tready =0;
    ##15 tready = 1;
    ##1 tready = 0 ;
    ##8 tready = 1 ;
	##1 tready = 0 ;
end

initial
begin
data <=32'haaaa_bbbb;
##15
data <=32'hcccc_dddd;
end

initial 
##40 $finish;

endmodule
