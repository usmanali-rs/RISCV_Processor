module RISCV_Processor_tb;
reg clk,rst;

  task clock (input integer number);
    repeat (number) begin clk=0; #1; clk=1; #1; end
  endtask

  task reset;
    begin
      rst = 1; clock(1);
      rst = 0; clock(1);
    end
  endtask

RISCV_Processor_pipelined single_cycle_risc_inst(clk,rst);

initial begin
// checking total number of even and odd numbers in a series by saving it in an array of words(4bytes)
	// initial number of seires 3x+1, must be saved in x28 register
	single_cycle_risc_inst.rfile.register[28] = 32'd3;  
	// total numbers to be stored in array, must be saved in x21 register
	single_cycle_risc_inst.rfile.register[21] = 32'd10;
        $readmemh("even_odd_from_stored_series.text", single_cycle_risc_inst.im.Instruction) ;
	// total even numbers are saved in x8 register and odd numebrs are saved in x9 register
	// you can also check saved array in dmemory
        
// to check that all instructions are workin uncomment this line
	//$readmemh("RISCV_test1.text", single_cycle_risc_inst.im.Instruction) ;

// to check nth fibonacci number 
        //$readmemh("fibonacci_test.text", single_cycle_risc_inst.im.Instruction) ;
	reset;
	clock(2000);

$finish;
end
endmodule 