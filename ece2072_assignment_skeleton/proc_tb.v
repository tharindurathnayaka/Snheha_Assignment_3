
`include "proc.v"
`timescale 1ns/1ns
/*
Monash University ECE2072: Assignment 
This file contains a Verilog test bench to test the correctness of the processor.

Please enter your student ID:

*/
module proc_tb;
    
    
    reg clk=0;
    reg rst;
    reg[8:0]din;
    wire[3:0]TICK;

    wire [15:0] bus, R0, R1, R2, R3, R4, R5, R6, R7;

    always #5 clk = ~clk;

    simple_proc simple_proc1(clk, rst, din, bus, R0, R1, R2, R3, R4, R5, R6, R7,TICK);



      initial 
    begin
        $dumpfile("cpu_tb.vcd");
        $dumpvars(1, simple_proc1);
        
        
    end


    initial begin
     clk=0   ;

    $display("clk :",clk);
    $display("rst :",rst);
     $display("tick :%b",TICK);
    $display("din :%b",din);
    $display("bus :%b",bus);
    $display("R0 :",R0);
    $display("R0 :",R1);
    $display("R0 :",R2);
    $display("R0 :",R3);
    $display("R0 :",R4);
    $display("R0 :",R5);
    $display("R0 :",R6);
    $display("R0 :",R7);

    rst=1'b1;
  
     #6  

    $display("clk :",clk);
    $display("rst :",rst);
     $display("tick :%b",TICK);
    $display("din :%b",din);
    $display("bus :%b",bus);
    $display("R0 :",R0);
    $display("R0 :",R1);
    $display("R0 :",R2);
    $display("R0 :",R3);
    $display("R0 :",R4);
    $display("R0 :",R5);
    $display("R0 :",R6);
    $display("R0 :",R7);

    //INS1------------------------------
    rst=1'b0;
    din=9'b010100011;
     
    #10

    
    $display("clk :",clk);
    $display("rst :",rst);
    $display("tick :%b",TICK);
    $display("din %b:",din);
    $display("bus :%b",bus);
    $display("R0 :",R0);
    $display("R0 :",R1);
    $display("R0 :",R2);
    $display("R0 :",R3);
    $display("R0 :",R4);
    $display("R0 :",R5);
    $display("R0 :",R6);
    $display("R0 :",R7);

   
    #10

    
    $display("clk :",clk);
    $display("rst :",rst);
     $display("tick :%b",TICK);
    $display("din :%b",din);
    $display("bus :%b",bus);
    $display("R0 :",R0);
    $display("R0 :",R1);
    $display("R0 :",R2);
    $display("R0 :",R3);
    $display("R0 :",R4);
    $display("R0 :",R5);
    $display("R0 :",R6);
    $display("R0 :",R7);


    din=9'b000000011;
    #10

    
    $display("clk :",clk);
    $display("rst :",rst);
     $display("tick :%b",TICK);
    $display("din :%b",din);
    $display("bus :%b",bus);
    $display("R0 :",R0);
    $display("R0 :",R1);
    $display("R0 :",R2);
    $display("R0 :",R3);
    $display("R0 :",R4);
    $display("R0 :",R5);
    $display("R0 :",R6);
    $display("R0 :",R7);



   #10

    
    $display("clk :",clk);
    $display("rst :",rst);
     $display("tick :%b",TICK);
    $display("din :%b",din);
    $display("bus :%b",bus);
    $display("R0 :",R0);
    $display("R0 :",R1);
    $display("R0 :",R2);
    $display("R0 :",R3);
    $display("R0 :",R4);
    $display("R0 :",R5);
    $display("R0 :",R6);
    $display("R0 :",R7);

   //INS 2------------------------------------------
   din=9'b010101011;
    #20

   din=9'b000000010;

    #30

    
    $display("clk :",clk);
    $display("rst :",rst);
     $display("tick :%b",TICK);
    $display("din :%b",din);
    $display("bus :%b",bus);
    $display("R0 :",R0);
    $display("R0 :",R1);
    $display("R0 :",R2);
    $display("R0 :",R3);
    $display("R0 :",R4);
    $display("R0 :",R5);
    $display("R0 :",R6);
    $display("R0 :",R7);
    
    din=9'b001101100;

    #50

    $display("clk :",clk);
    $display("rst :",rst);
     $display("tick :%b",TICK);
    $display("din :%b",din);
    $display("bus :%b",bus);
    $display("R0 :",R0);
    $display("R0 :",R1);
    $display("R0 :",R2);
    $display("R0 :",R3);
    $display("R0 :",R4);
    $display("R0 :",R5);
    $display("R0 :",R6);
    $display("R0 :",R7);





    
    
    $finish;



    end

    


   

endmodule