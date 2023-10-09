/*
Monash University ECE2072: Assignment 
This file contains Verilog code to implement individual the CPU.

Please enter your student ID:

*/
`include "components.v"
`timescale 1ns/1ns

module simple_proc(clk, rst, din, bus, R0, R1, R2, R3, R4, R5, R6, R7,TICK_V);
    // inputs and outputs:
    input clk,rst;
    input [8:0]din;
    output [15:0]bus;
    output [15:0]R0, R1, R2, R3, R4, R5, R6, R7 ;
    output[3:0]TICK_V;


    // declare wires:
     wire [15:0]BUS;
     wire[15:0] W_R0,W_R1,W_R2,W_R3,W_R4,W_R5,W_R6,W_R7,W_G,W_A,ALU_Result;
     wire [8:0]W_IR;
     wire [15:0]Sign_extender;
     wire[8:0] IR;
     wire [3:0]Tick;
     reg R0_enable,R1_enable,R2_enable,R3_enable,R4_enable,R5_enable,R6_enable,R7_enable,G_enable,IR_enable,A_enable,Tick_enable;
     reg [3:0]Mux_sel;
     reg [2:0]ALU_OP;

     assign TICK_V =Tick;
     assign R0=W_R0;
     assign R1=W_R1;
     assign R2=W_R2;
     assign R3=W_R3;
     assign R4=W_R4;
     assign R5=W_R5;
     assign R6=W_R6;
     assign R7=W_R7;
     assign bus =BUS;

  



    // instantiate regiSign extnder
    sign_extend sign_extend1(din,Sign_extender);


    // instantiate registers:
    register_16 r0(BUS,R0_enable,clk,W_R0,rst);
    register_16 r1(BUS,R1_enable,clk,W_R1,rst);
    register_16 r2(BUS,R2_enable,clk,W_R2,rst);
    register_16 r3(BUS,R3_enable,clk,W_R3,rst);
    register_16 r4(BUS,R4_enable,clk,W_R4,rst);
    register_16 r5(BUS,R5_enable,clk,W_R5,rst);
    register_16 r6(BUS,R6_enable,clk,W_R6,rst);
    register_16 r7(BUS,R7_enable,clk,W_R7,rst);
    register_16 a(BUS,A_enable,clk,W_A,rst);
    register_16 g(ALU_Result,G_enable,clk,W_G,rst);
    register_9 ir (din,IR_enable,clk,W_IR,rst);
    
    // instantiate Multiplexer:
    multiplexer multiplexer1(Sign_extender,W_R0,W_R1,W_R2,W_R3,W_R4,W_R5,W_R6,W_R7,W_G,Mux_sel,BUS);
    
    // nstantiate ALU:
    
    alu alu1(W_A,BUS,ALU_OP,ALU_Result);
    // instantiate tick counter:
    tick_FSM tick_FSM1(rst,clk,1'b1,Tick);
    
    // TODO: define control unit:
    always @(Tick) begin

       IR_enable=1'b0;

        R0_enable=1'b0;
        R0_enable=1'b0;
        R1_enable=1'b0;
        R2_enable=1'b0;
        R3_enable=1'b0;
        R4_enable=1'b0;
        R5_enable=1'b0;
        R6_enable=1'b0;
        R7_enable=1'b0;
        G_enable=1'b0;
        A_enable=1'b0;
        Mux_sel =4'b1111;
        ALU_OP =3'b111;

       
        case (Tick)
                4'b0001:
                begin
                    IR_enable=1'b1;

                    R0_enable=1'b0;
                    R0_enable=1'b0;
                    R1_enable=1'b0;
                    R2_enable=1'b0;
                    R3_enable=1'b0;
                    R4_enable=1'b0;
                    R5_enable=1'b0;
                    R6_enable=1'b0;
                    R7_enable=1'b0;
                    G_enable=1'b0;
                    A_enable=1'b0;

                     Mux_sel =4'b1111;
                     ALU_OP =3'b111;

  
                end
            
                4'b0010:
                begin

                    IR_enable=1'b0;
                    R0_enable=1'b0;
                    R0_enable=1'b0;
                    R1_enable=1'b0;
                    R2_enable=1'b0;
                    R3_enable=1'b0;
                    R4_enable=1'b0;
                    R5_enable=1'b0;
                    R6_enable=1'b0;
                    R7_enable=1'b0;
                    G_enable=1'b0;
                    A_enable=1'b1;

                     Mux_sel ={2'b00,W_IR[5:3]};
                     ALU_OP =3'b111;
                    
                end
            
                4'b0100:
                begin
                    IR_enable=1'b0;
                    R0_enable=1'b0;
                    R0_enable=1'b0;
                    R1_enable=1'b0;
                    R2_enable=1'b0;
                    R3_enable=1'b0;
                    R4_enable=1'b0;
                    R5_enable=1'b0;
                    R6_enable=1'b0;
                    R7_enable=1'b0;
                    G_enable=1'b1;
                    A_enable=1'b0;

                    


                    case(W_IR[8:6])

                        3'b000:
                        begin
                            ALU_OP=3'b111;
                            Mux_sel =4'b1111;

                        end

                        3'b001:
                        begin

                            ALU_OP=3'b000;
                            Mux_sel ={2'b00,W_IR[2:0]};

                        end
                        3'b010:
                        begin
                            ALU_OP=3'b000;
                            Mux_sel=4'b1000;


                        end

                         3'b011:
                        begin
                               ALU_OP=3'b001;
                               Mux_sel ={2'b00,W_IR[2:0]};

                        end

                         3'b100:
                        begin
                               ALU_OP=3'b010;
                               Mux_sel ={2'b00,W_IR[2:0]};

                        end

                        3'b101:
                        begin
                               ALU_OP=3'b011;
                                Mux_sel =4'b1111;

                        end
                        3'b110:
                        begin
                               ALU_OP=3'b100;
                                Mux_sel =4'b1111;

                        end
                        3'b111:
                        begin
                               ALU_OP=3'b111;
                               Mux_sel=4'b1000;


                        end



                    endcase
                    
                    
                end
            
                4'b1000:
                begin

                    IR_enable=1'b0;
                    R0_enable=1'b0;
                    R0_enable=1'b0;
                    R1_enable=1'b0;
                    R2_enable=1'b0;
                    R3_enable=1'b0;
                    R4_enable=1'b0;
                    R5_enable=1'b0;
                    R6_enable=1'b0;
                    R7_enable=1'b0;
                    G_enable=1'b0;
                    A_enable=1'b0;

                    Mux_sel =4'b1001;
                    ALU_OP =3'b111;

                    case(W_IR[5:3])

                        3'b000:
                        begin
                            R0_enable=1'b1;

                        end

                        3'b001:
                        begin

                             R1_enable=1'b1;

                        end
                        3'b010:
                        begin
                             R2_enable=1'b1;

                        end

                         3'b011:
                        begin
                            R3_enable=1'b1;

                        end

                         3'b100:
                        begin
                                R4_enable=1'b1;

                        end

                        3'b101:
                        begin
                                R5_enable=1'b1;

                        end
                        3'b110:
                        begin
                                R6_enable=1'b1;

                        end
                        3'b111:
                        begin
                                R7_enable=1'b1;

                        end



                    endcase
                    

                    


                    
                end
            
            default:
                begin
                    // TODO
                end

        endcase

    end

endmodule