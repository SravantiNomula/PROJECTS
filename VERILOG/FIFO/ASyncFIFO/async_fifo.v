/*
-->In a synchronous FIFO design, one way to determine whether a FIFO is full or empty is to use separate count register
to track the number of entries in the FIFO. This requires the ability to both increment and decrement the counter, 
potentially on the same clock. The same technique cannot be used in an asynchronous FIFO, however, because two 
different clocks will be needed to control the counter.

-->One design technique used to distinguish between full and empty is to add an extra bit to each pointer. When the
write pointer increments past the final FIFO address, the write pointer will increment the unused MSB while setting
the rest of the bits back to zero.

-->FIFO is empty when both pointers, including the MSBs are equal. And the FIFO is full when both pointers, except
the MSBs are equal.

-->A common approach to FIFO counter-pointers, is to use Gray code counters. Gray codes only allow one bit to
change for each clock transition, eliminating the problem associated with trying to synchronize multiple changing
signals on the same clock edge
*/

module fifo1 #(parameter DSIZE = 8,
 parameter ASIZE = 4)
 
 (output [DSIZE-1:0] rdata,
 output wfull,
 output rempty,
 
  input [DSIZE-1:0] wdata,
 input winc, wclk, wrst_n,
 input rinc, rclk, rrst_n);
 
 wire [ASIZE-1:0] waddr, raddr;
 wire [ASIZE:0] wptr, rptr, wq2_rptr, rq2_wptr;
 
 sync_r2w sync_r2w (.wq2_rptr(wq2_rptr), .rptr(rptr),
 .wclk(wclk), .wrst_n(wrst_n));
 
 sync_w2r sync_w2r (.rq2_wptr(rq2_wptr), .wptr(wptr),
 .rclk(rclk), .rrst_n(rrst_n));
 
 fifomem #(DSIZE, ASIZE) fifomem
 (.rdata(rdata), .wdata(wdata),
 .waddr(waddr), .raddr(raddr),
 .wclken(winc), .wfull(wfull),
 .wclk(wclk));
 
 rptr_empty #(ASIZE) rptr_empty
 (.rempty(rempty),
 .raddr(raddr),
 .rptr(rptr), .rq2_wptr(rq2_wptr),
 .rinc(rinc), .rclk(rclk),
 .rrst_n(rrst_n));
 
 wptr_full #(ASIZE) wptr_full
 (.wfull(wfull), .waddr(waddr),
 .wptr(wptr), .wq2_rptr(wq2_rptr),
 .winc(winc), .wclk(wclk),
 .wrst_n(wrst_n));
 
endmodule
