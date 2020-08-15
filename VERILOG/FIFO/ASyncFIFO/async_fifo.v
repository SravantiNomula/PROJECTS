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
