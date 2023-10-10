
/*
Monash University ECE2072: Assignment 


Please enter your student ID:

*/
`include "components.v"
`timescale 1ns/1ns

module components_tb;


    // Clock generation
    reg clk = 0;
    always #5 clk = ~clk;

    // Declare signals

    // Sign_extender module
     reg [8:0] in_data;
     wire [15:0] out_data;

    //Tick  FSM module 
     reg enable;
     reg rst;
     wire [3:0] tick;

    // ALU module 
     reg [15:0] input_a, input_b;
     reg [2:0] alu_op;
     wire [15:0] result;

    // Multiplxer module
     reg [15:0] SignExtDin, R0, R1, R2, R3, R4, R5, R6, R7, G;
     reg [3:0] sel;
     wire [15:0] Bus;

    // Register module 
     reg [8:0] r_in_9b;
     reg reg_enable_9b;
     wire [8:0] Q_9b;

     reg [15:0] r_in_16b;
     reg reg_enable_16b;
     wire [15:0] Q_16b;


     // Instantiate the modules
     //Sign extender module
     sign_extend se1(
         .in(in_data),
         .ext(out_data)
     );
    //tick FSM module
    tick_FSM tick_FSM1 (
         .clk(clk),
         .enable(enable),
         .rst(rst),
         .tick(tick)
     );
    //ALU module
    alu alu1 (
         .input_a(input_a),
         .input_b(input_b),
         .alu_op(alu_op),
         .result(result)
     );
    //Multiplexer module
     multiplexer uut (
         .SignExtDin(SignExtDin),
         .R0(R0),
         .R1(R1),
         .R2(R2),
         .R3(R3),
         .R4(R4),
         .R5(R5),
         .R6(R6),
         .R7(R7),
         .G(G),
         .sel(sel),
        .Bus(Bus)
  );
   //Register 9 module
    register_9 reg9 (
         .r_in(r_in_9b),
         .enable(reg_enable_9b),
         .clk(clk),
         .rst(rst),
         .Q(Q_9b)
    );
    //Register 16 module
     register_16 reg16 (
         .r_in(r_in_16b),
         .enable(reg_enable_16b),
         .clk(clk),
         .rst(rst),
         .Q(Q_16b)
    );


     initial begin

     //Testing modules 

     $display("------------------------------------------------------------");
     $display("                  Testbench for Components                  ");
     $display("------------------------------------------------------------");

     $display("");

    //Test1- Testing Testing sign_extender module-------------------------------------------------
     $display("--------------------------------------");
     $display(" Test1 -Testing sign_extender module");
     $display("--------------------------------------");

     // Test with positive number (e.g., 0x123)
     in_data = 9'b000100110; // 0x123
     #10;
     $display("Input: %b, Output: %b", in_data, out_data);

     // Test with negative number (e.g., -0x123)
     in_data = 9'b100100110; // -0x123
     #10;
     $display("Input: %b, Output: %b", in_data, out_data);

    $display("");





     //Test2- Testing Testing tick  FSM module-----------------------------------------------------
    $display("--------------------------------------");
    $display(" Test2 -Testing tick FSM module");
    $display("--------------------------------------");


     // Initialize signals
        clk = 0;
        enable = 0;
        rst = 0;

        // Apply rst
        rst = 1;
        #20 rst = 0;

        // Enable FSM
        enable = 1;

        // Monitor the tick output
        $display("                 Time, tick");
        $monitor("%t, %b", $time, tick);

        #100
        $monitoroff;

     $display("");





     //Test3- Testing Testing ALU module---------------------------------------------------------------
    $display("--------------------------------------");
    $display(" Test3 -Testing ALU module");
    $display("--------------------------------------");

    // Initialize inputs
    input_a= 16'd8;
    input_b= 16'd5;
    alu_op = 3'b000; // ALU operation: Addition

    // Apply test vectors and display results
    $display("Test Case: Addition");
    $display("input_a= %d, input_b = %d, alu_op = %b", input_a, input_b, alu_op);
    #3; // Wait for some time
    $display("Result = %d", result);
    
     $display("                   ");
  
    // Initialize inputs
    input_a= 16'd8;
    input_b= 16'd5;
    alu_op = 3'b001; // ALU operation: subtraction

    // Apply test vectors and display results
    $display("Test Case: Subtraction");
    $display("input_a = %d, input_b = %d, alu_op = %b", input_a, input_b, alu_op);
    #3; // Wait for some time
    $display("Result = %d", result);
    
     $display("                   ");
    //Initialize inputs
    input_a= 16'd8;
    input_b= 16'd5;
    alu_op = 3'b010; // ALU operation: mltipication

    // Apply test vectors and display results
    $display("Test Case: Multiplication");
    $display("input_a = %d, input_b = %d, alu_op = %b", input_a, input_b, alu_op);
    #3; // Wait for some time
    $display("Result = %d", result);

    $display("                   ");
        // Initialize inputs
    input_a= 16'd8;
    input_b= 16'd5;
    alu_op = 3'b011; // ALU operation: right shift

    // Apply test vectors and display results
    $display("Test Case: Right Shift");
    $display("input_a = %d, input_b = %d, alu_op = %b", input_a, input_b, alu_op);
    #3; // Wait for some time
    $display("Result = %d", result);
    

     $display("                   ");
     // Initialize inputs
    input_a= 16'd8;
    input_b= 16'd5;
    alu_op = 3'b100; // ALU operation: left shift

    // Apply test vectors and display results
    $display("Test Case: Left shitf");
    $display("input_a = %d, input_b = %d, alu_op = %b", input_a, input_b, alu_op);
    #3; // Wait for some time
    $display("Result = %d", result);
     $display("");





     //Test3- Testing Testing Multiplexer module---------------------------------------------------------
    $display("--------------------------------------");
    $display(" Test4 -Testing Multiplexer module");
    $display("--------------------------------------");

     // Initialize inputs
    SignExtDin = 16'd 8;
    R0 = 16'd0;
    R1 = 16'd1;
    R2 = 16'd2;
    R3 = 16'd3;
    R4 = 16'd4;
    R5 = 16'd5;
    R6 = 16'd6;
    R7 = 16'd7;
    G =  16'd9;

    //Display initial inputs
    $display("");
     
    $display("Input R0               : %d" ,R0);
    $display("Input R1               : %d" ,R1);
    $display("Input R2               : %d" ,R2);
    $display("Input R3               : %d" ,R3);
    $display("Input R4               : %d" ,R4);
    $display("Input R5               : %d" ,R5);
    $display("Input R6               : %d" ,R6);
    $display("Input R7               : %d" ,R7);
    $display("Input Sign Extender    : %d" ,SignExtDin);
    $display("Input G                : %d" ,G);

    // Apply test cases
    $display(" ");
    $display("Test cases ");
    $display(" ");
    sel = 4'b0000;
     #1
     $display("sel :%b,  Bus : %d", sel,Bus);
     sel = 4'b0001;
     #1
     $display("sel :%b,  Bus : %d", sel,Bus);
     sel = 4'b0010;
     #1
     $display("sel :%b,  Bus : %d", sel,Bus);
     sel = 4'b0011;
     #1
     $display("sel :%b,  Bus : %d", sel,Bus);
     sel = 4'b0100;
     #1
     $display("sel :%b,  Bus : %d", sel,Bus);
     sel = 4'b0101;
     #1
     $display("sel :%b,  Bus : %d", sel,Bus);
     sel = 4'b0110;
     #1
     $display("sel :%b,  Bus : %d", sel,Bus);
     sel = 4'b0111;
     #1
     $display("sel :%b,  Bus : %d", sel,Bus);
     sel = 4'b1000;
     #1
     $display("sel :%b,  Bus : %d", sel,Bus);
     sel = 4'b1001;
     #1
     $display("sel :%b,  Bus : %d", sel,Bus);
     $display(" ");




    
     //Test4- Testing Testing Register_16 module----------------------------------------------------------
    $display("--------------------------------------");
    $display(" Test5 -Testing  Register_16 module");
    $display("--------------------------------------");


    $display("Register_16 inputs : %d,%d" ,120,250);
    reg_enable_16b = 1;
    rst = 0;
    r_in_16b = 16'd0; // Set your initial input value here
        
    // Apply initial inputs and clock
    #10 rst = 1;
    #10 rst = 0;

    $display("Register_16  Q:  %d" ,Q_16b);
        
    // Test case 1: Load a value into the register
    r_in_16b = 16'd120; // Set your test input value here
    #10;

     $display("Register_16  Q:  %d" ,Q_16b);
        
    // Test case 2: Another load operation
    r_in_16b = 16'd250; // Set your test input value here
     #10;

    $display("Register_16  Q:  %d" ,Q_16b);

    $display(" ");
    
     //Test5- Testing Testing Register_9 module-----------------------------------------------------------
    $display("--------------------------------------");
    $display(" Test6 -Testing Register_9 module");
    $display("--------------------------------------");

    $display("Register_9 inputs : %d,%d" ,5,6);
    reg_enable_9b = 1;
    rst = 0;
    r_in_9b = 9'd5; // Set your initial input value here
        
    // Apply initial inputs and clock
    #10 rst = 1;
    #10 rst = 0;

    $display("Register_9  Q:  %d" ,Q_9b);
        
    // Test case 1: Load a value into the register
    r_in_9b = 9'd5; // Set your test input value here
    #10;

     $display("Register_9  Q:  %d" ,Q_9b);
        
    // Test case 2: Another load operation
    r_in_9b = 9'd6; // Set your test input value here
     #10;

      $display("Register_9  Q:  %d" ,Q_9b);
    $finish;
    end


endmodule
//------------------------------------------------------------EOC-----------------------------------------------------------