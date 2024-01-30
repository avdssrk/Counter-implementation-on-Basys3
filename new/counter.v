`timescale 1ns / 1ps

module counter(input clk, input rst,output reg [6:0] LED_out, output [3:0] LED_anode);
    wire clk_1s;
    reg [6:0] counter;
    reg [18:0] display_counter;
    reg [3:0] BCD_counter;
    
    
    clock_gen gen_1s_clk(clk,rst,clk_1s); // generating the 1s clock for changing the count
    
    // counter to refresh the LEDs every 10.4ms
    always @(posedge clk) begin
        if(rst)
            display_counter <= 0;
        else
            display_counter <= display_counter +1;
    end
    
    assign LED_anode[0] =  display_counter[18];
    assign LED_anode[1] = ~display_counter[18];
    assign LED_anode[2] =  1;
    assign LED_anode[3] =  1;
    
    // counter to display
    always @(posedge clk_1s) begin
        if(rst)
            counter <= 3'b000;
        else if(counter == 99)
                counter <=0;
        else
            counter <= counter +1;
    end
    
    // getting the BCD digit to display
    always @(*) begin
        case(LED_anode)
            4'b1100: BCD_counter = 0;
            4'b1110: BCD_counter = counter%10;
            4'b1101: BCD_counter = counter/10;
            4'b1111: BCD_counter = 0;
            default: BCD_counter = 0;
        endcase
    end  
    
    // converting the BCD to seven segments
    always @(*) begin
        case(BCD_counter)
            4'b0000: LED_out = 7'b0000001;
            4'b0001: LED_out = 7'b1001111;
            4'b0010: LED_out = 7'b0010010;
            4'b0011: LED_out = 7'b0000110;
            4'b0100: LED_out = 7'b1001100;
            4'b0101: LED_out = 7'b0100100;
            4'b0110: LED_out = 7'b0100000;
            4'b0111: LED_out = 7'b0001111;
            4'B1000: LED_out = 7'b0000000;
            4'b1001: LED_out = 7'b0001100;            
            default: LED_out = 7'b0000001;
        endcase    
    end  
endmodule