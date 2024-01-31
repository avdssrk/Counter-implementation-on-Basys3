`timescale 1ns / 1ps
//////////////////////////////////////////////////////////////////////////////////
// Company: 
// Engineer: 
// 
// Create Date: 08.01.2024 22:27:47
// Design Name: 
// Module Name: test_bench
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


module test_bench();
    reg clk = 0;
    reg rst;
    wire [6:0] LED_out;
    wire [3:0] LED_anode;
    
    counter dut(clk,rst,LED_out,LED_anode);
    
    always #10 clk=~clk;
    
    initial begin
        rst = 1;
        #250 rst =0;
        
    end


endmodule
