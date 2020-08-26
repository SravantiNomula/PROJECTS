//-------------------------------------------
//Author:  Nguyen Hung Quan
//Website: http://nguyenquanicd.blogspot.com/
//Date    : 2019.Aug.22
//Function: Simple Round Robin (RR) Arbiter
//  - Only use a counter to share access right
//  - One request source, one time slice/slot
//-------------------------------------------
module ArbSimpleRR (
  clk,
  rst_n,
  req,
  grant
  );
  
  
  parameter REQ_NUM    = 4;                 //Number of sources requesting access 
	parameter COUNTER_W  = clog2(REQ_NUM);    // Number of bits required to denote the sources here log2(4)-->2
						//obtained using a function written in the end			
  //
  input  clk;
  input  rst_n;
  input  [REQ_NUM-1:0] req;
  output reg [REQ_NUM-1:0] grant;
  //
  reg [COUNTER_W-1:0] count;
  wire noGrant;
  
  /////////////NO GRANT LOGIC////////////////////
  
  assign noGrant    = ~|grant[REQ_NUM-1:0];
	
 //////////////COUNTER LOGIC/////////////////////////////// 
  always @ (posedge clk, negedge rst_n) begin
    if (~rst_n)
	   count[COUNTER_W-1:0] <= {COUNTER_W{1'b0}}; 
	  else if (noGrant) begin
//If we dont have a grant we keep counting through all the sources cyclically                                         	  
	    	if (count[COUNTER_W-1:0] == REQ_NUM-1)		
			count[COUNTER_W-1:0] <= {COUNTER_W{1'b0}};     //To wrap around
	    	else
		    count[COUNTER_W-1:0] <= count[COUNTER_W-1:0] + 1'b1 // WE increment the counter to point to next source every cycle if nogrant
	  end
  end
  ///////////////////////////////////////////////////
  //CREATE GRANT LOGIC//////////////////////////////////// 
  generate
    genvar i;
    //
	  for (i = 0; i < REQ_NUM; i=i+1) begin: uGrant
      always @ (posedge clk, negedge rst_n) 
begin
        if (~rst_n)
	      grant[i] <= 1'b0;
	    else if (noGrant)
		    grant[i] <= req[i] & (count[COUNTER_W-1:0] == i);// If we dont have any grant we keep on 
	      					//Rotating from one source to another and give chance so that if it
	      					//Raises a request we give it grant	
     	    else
		    grant[i] <= req[i] & grant[i];// If we have a grant already and again get a request
						//then we keep the same count as shown above and keep the grant high
 end
	  end //for loop
  endgenerate
  //
  //
  function integer clog2; 
    input integer value; 
    integer i; 
    begin 
      clog2 = 0; 
      for(i = 0; 2**i < value; i = i + 1) 
        clog2 = i + 1; 
      end 
  endfunction
endmodule //ArbSimpleRR
