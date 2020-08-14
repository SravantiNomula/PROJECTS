/*

For synchronous FIFO design (a FIFO where writes to, and reads from the FIFO buffer are conducted in the same
clock domain), one implementation counts the number of writes to, and reads from the FIFO buffer to increment (on
FIFO write but no read), decrement (on FIFO read but no write) or hold (no writes and reads, or simultaneous write
and read operation) the current fill value of the FIFO buffer. The FIFO is full when the FIFO counter reaches a
predetermined full value and the FIFO is empty when the FIFO counter is zero.

*/

module syn_fifo (
clk      , // Clock input
rst      , // Active high reset
wr_cs    , // Write chip select
rd_cs    , // Read chipe select
data_in  , // Data input
rd_en    , // Read enable
wr_en    , // Write Enable
data_out , // Data Output
empty    , // FIFO empty
full       // FIFO full
);    
 
// FIFO constants
parameter DATA_WIDTH = 8;
parameter ADDR_WIDTH = 8;
parameter RAM_DEPTH = (1 << ADDR_WIDTH);
// Port Declarations
input clk ;
input rst ;
input wr_cs ;
input rd_cs ;
input rd_en ;
input wr_en ;
input [DATA_WIDTH-1:0] data_in ;
output full ;
output empty ;
output [DATA_WIDTH-1:0] data_out ;

//-----------Internal variables-------------------
reg [ADDR_WIDTH-1:0] wr_pointer;
reg [ADDR_WIDTH-1:0] rd_pointer;
reg [ADDR_WIDTH :0] status_cnt;
reg [DATA_WIDTH-1:0] data_out ;
wire [DATA_WIDTH-1:0] data_ram ;

//-----------Variable assignments---------------
assign full = (status_cnt == (RAM_DEPTH-1));
assign empty = (status_cnt == 0);

//-----------WRITE AND READ POINTER CALCULATION---------------------------
always @ (posedge clk or posedge rst)
begin : WRITE_POINTER
  if (rst) 
   begin
    wr_pointer <= 0;
   end 
  else 
   if (wr_cs && wr_en )
    begin
     wr_pointer <= wr_pointer + 1;
    end
end

always @ (posedge clk or posedge rst)
begin : READ_POINTER
  if (rst) begin
    rd_pointer <= 0;
  end 
 else 
  if (rd_cs && rd_en ) 
   begin
    rd_pointer <= rd_pointer + 1;
   end
  end
///-----------READING THE DATA THROUGH DATA OUT---------
always  @ (posedge clk or posedge rst)
begin : READ_DATA
  if (rst) 
   begin
    data_out <= 0;
   end 
 else 
  if (rd_cs && rd_en ) 
   begin
    data_out <= data_ram;
   end
  end
//------MAINTAINING THE STATUS COUNT VALUE--increment: WRITE only;decrement: READ ONLY; ELSE HOLD
always @ (posedge clk or posedge rst)
begin : STATUS_COUNTER
  if (rst) begin
    status_cnt <= 0;
  // Read but no write.
  end else if ((rd_cs && rd_en) && !(wr_cs && wr_en) 
                && (status_cnt != 0)) begin
    status_cnt <= status_cnt - 1;
  // Write but no read.
  end else if ((wr_cs && wr_en) && !(rd_cs && rd_en) 
               && (status_cnt != RAM_DEPTH)) begin
    status_cnt <= status_cnt + 1;
  end
end 
   
ram_dp_ar_aw #(DATA_WIDTH,ADDR_WIDTH)DP_RAM (
.address_0 (wr_pointer) , // address_0 input 
.data_0    (data_in)    , // data_0 bi-directional
.cs_0      (wr_cs)      , // chip select
.we_0      (wr_en)      , // write enable
.oe_0      (1'b0)       , // output enable
.address_1 (rd_pointer) , // address_q input
.data_1    (data_ram)   , // data_1 bi-directional
.cs_1      (rd_cs)      , // chip select
.we_1      (1'b0)       , // Read enable
.oe_1      (rd_en)        // output enable
);     

endmodule
