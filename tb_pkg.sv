
`ifndef TB_PKG
`define TB_PKG
`include "uvm_macros.svh"
package tb_pkg;
 import uvm_pkg::*;
 `include "sr_sequence_item.sv"        // transaction class
 `include "sr_sequence.sv"             // sequence class
 `include "sr_sequencer.sv"            // sequencer class
 `include "sr_driver.sv"               // driver class
 `include "sr_monitor.sv"              // monitor class
 `include "sr_agent.sv"                // agent class  
 `include "sr_coverage.sv"             // coverage class
 `include "sr_scoreboard.sv"           // scorebaord class
 `include "sr_env.sv"                  // environment class

 `include "sr_test.sv"                   // test1
 //`include "test2.sv"
 //`include "test3.sv"

endpackage
`endif 


