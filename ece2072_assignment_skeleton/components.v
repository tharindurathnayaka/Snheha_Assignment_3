/*
Monash University ECE2072: Assignment 

Please enter your name and student ID:

*/

`timescale 1ns/1ns

// Sign extender module-------------------------------------------------

module sign_extend(in,ext);

input[8:0] in;
output reg[15:0] ext;

always @(in)
begin
if (in[8] == 1'b0) begin
        ext <= {7'b0000000, in}; // Positive number, extend with zeros
    end 
else begin
        ext <= {7'b1111111, in}; // Negative number, extend with ones
end
end

endmodule

// Tick FSM Module----------------------------------------------------

module tick_FSM(rst, clk, enable, tick);

input  clk,enable,rst;
output  [3:0] tick;

// Define state enumeration
parameter S0 = 4'b0001;
parameter S1 = 4'b0010;
parameter S2 = 4'b0100;
parameter S3 = 4'b1000;
parameter SI = 4'b0000;

// Define state register
reg [3:0] current_state, next_state,reg1;

//Outputs
assign tick=current_state;

// FSM logic
always @(negedge clk ) begin
    
    if ( rst==1'b1) begin

       
        current_state = SI;
    end 

    else if (enable) begin
        case (current_state)
            SI: next_state <= S0;
            S0: next_state <= S1;
            S1: next_state <= S2;
            S2: next_state <= S3;
            S3: next_state <= S0;
            default: next_state <= S0;
        endcase
    end
end

// State register update
always @(posedge clk) begin
    if (enable & ~rst) begin
        current_state <= next_state;
    end
end

endmodule

// ALU module -----------------------------------------------------
module alu(input_a, input_b,alu_op,result);
// InPut Ports
input [15:0] input_a, input_b;
input [2:0]alu_op;
output reg [15:0]result;

//Internal wires
wire [15:0] result_add,result_sub,result_lshift,result_rshift,result_mul;

//Generate Intermideate results
assign #1 result_add =input_a+input_b;
assign #1 result_sub =input_a -input_b;
assign #1 result_mul =input_a * input_b;
assign #1 result_lshift =input_b << 1;
assign #1 result_rshift =input_b >> 1;

//Send correct result according to opcode
  always @(*)
  begin

    case (alu_op)
         3'b000     : result =result_add;
         3'b001     : result=result_sub;
         3'b010     : result =result_mul;
         3'b011     : result=result_rshift;
         3'b100     : result=result_lshift;
         default : result=16'd0;

    endcase
  end


endmodule 

//Multiplexer module----------------------------------------------------------

module multiplexer(SignExtDin, R0, R1, R2, R3, R4, R5, R6, R7, G, sel, Bus);

//input-output ports
input [15:0] SignExtDin, R0, R1, R2, R3, R4, R5, R6, R7, G;
input [3:0]sel;
output reg[15:0] Bus;

always @(*) begin
    case (sel)
        4'b0000: Bus = R0;
        4'b0001: Bus = R1;
        4'b0010: Bus = R2;
        4'b0011: Bus = R3;
        4'b0100: Bus = R4;
        4'b0101: Bus = R5;
        4'b0110: Bus = R6;
        4'b0111: Bus = R7;
        4'b1000: Bus = SignExtDin;
        4'b1001: Bus = G;
        default: Bus = 16'd0; // Default case (optional)
    endcase
end

endmodule

//Register_9 moduel---------------------------------------------------------
module register_9(r_in, enable, clk, Q, rst);

	parameter N = 9;
    //Input-Output ports
    input [N-1:0] r_in;
    input enable,clk,rst;
    output [N-1:0]Q;
    reg[N-1:0] register_9;

    assign #1 Q = register_9;

    //Register  update and reset logic
    always @(negedge clk)  begin

        if(rst)
        begin
           #1
           register_9 <= 9'd0;   // Reset the register
        end
        else 
        begin
           if(enable) 
             begin
             #1
             register_9 <= r_in; // Update the register 
             end

        end
    end
endmodule

//Register_16 module-------------------------------------------

module register_16(r_in, enable, clk, Q, rst);

	parameter N = 16;
 // Input-Output ports
    input [N-1:0] r_in;
    input enable,clk,rst;
    output [N-1:0]Q;

    reg[N-1:0] register_16;  // 16bit Register 

    assign #1 Q = register_16; // Assign output

   // Register update and resert Logic 
    always @(negedge clk)  begin

        if(rst)
        begin
           #1
           register_16 <= 16'd0;  // Reset the register
        end
        else 
        begin
           if(enable) 
             begin
             #1
             register_16 <= r_in;  //Update the register
             end

        end
    end
endmodule

//-------------------------------------------------------EOC-------------------------------------------------------------------