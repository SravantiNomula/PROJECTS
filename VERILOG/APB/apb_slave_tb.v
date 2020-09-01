module apb_regs_test #(datawidth = 32,
                       addresswidth = 8)();

reg clk, rst_n,pwrite,psel, penable;
reg [addresswidth-1:0]paddr;
reg [datawidth-1:0] pwdata;
 
  wire [datawidth-1:0]prdata;

  
apb_slave dut(clk,rst_n,paddr,pwdata,pwrite,psel,penable,prdata);
  


initial 
  begin
    clk = 0;
    rst_n = 0;
  $dumpfile("dump.vcd");
  $dumpvars();    
    
    #20;  
    //IDLE
    rst_n = 1;
    
    //WRITE
    //Setup state Setting data, address, 
    #20;
    paddr=8'h 26;
    pwdata=32'h 68;
    psel=1;
    pwrite=1;
    penable=0;
    
    #20;
	penable=1;
    
    #20;
    psel=0;
    penable=0;
    paddr=0;
    pwdata=0;
   
    
    //READ/////////////
    #20;
     paddr=8'h 26;
     psel=1;
    pwrite=0;
    penable=0; 
    
    #20;
    penable=1;
    
    #20;
    psel=0;
    penable=0;
   //WRITE/////////////////
     paddr=8'h 28;
    pwdata=32'h 52;
    psel=1;
    pwrite=1;
    penable=0;
    
    #20;
	penable=1;
    
    #20;
    psel=0;
    penable=0;
    paddr=0;
    pwdata=0;
   
   
    //READ//////////////////
    #20;
     paddr=8'h 28;
     psel=1;
    pwrite=0;
    penable=0; 
    
    #20;
    penable=1;
    
    #20;
    psel=0;
    penable=0;
    
    
    
    
    #100; 
     $finish;
  end
  
  always  #10 clk= ~clk; 
   
endmodule
