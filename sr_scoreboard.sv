
/***************************************************
  analysis_port from driver
  analysis_port from monitor
***************************************************/

`uvm_analysis_imp_decl( _drv )
`uvm_analysis_imp_decl( _mon )

class sr_scoreboard extends uvm_scoreboard;
  //----------------------------------------------------------------------------
  `uvm_component_utils(sr_scoreboard)
  //----------------------------------------------------------------------------

  //----------------------------------------------------------------------------
  uvm_analysis_imp_drv #(sr_sequence_item, sr_scoreboard) aport_drv;
  uvm_analysis_imp_mon #(sr_sequence_item, sr_scoreboard) aport_mon;
  //----------------------------------------------------------------------------

  //----------------------------------------------------------------------------
  uvm_tlm_fifo #(sr_sequence_item) expfifo;
  uvm_tlm_fifo #(sr_sequence_item) outfifo;
  //----------------------------------------------------------------------------

  //----------------------------------------------------------------------------
  int VECT_CNT, PASS_CNT, ERROR_CNT;
  logic t_s;
  logic t_r;
  logic t_q,temp_q;
  logic t_qbar,temp_qbar;

  function new(string name="sr_scoreboard",uvm_component parent);
    super.new(name,parent);
  endfunction
  //----------------------------------------------------------------------------


  //----------------------------------------------------------------------------  
  function void build_phase(uvm_phase phase);
  	super.build_phase(phase);
  	aport_drv = new("aport_drv", this);
  	aport_mon = new("aport_mon", this);
  	expfifo= new("expfifo",this);
  	outfifo= new("outfifo",this);
  endfunction
  //----------------------------------------------------------------------------

  //----------------------------------------------------------------------------
  function void write_drv(sr_sequence_item tr);
    `uvm_info("write_drv STIM", tr.input2string(), UVM_MEDIUM)
    t_r = tr.r;
    t_s = tr.s;
    t_q = temp_q;
    t_qbar = temp_qbar;

    if(t_s==0 && t_r==0) begin 
      temp_q    =  temp_q;
      temp_qbar = ~temp_q;
    end
    else if(t_s==0 && t_r==1) begin 
      temp_q    =  0;
      temp_qbar = ~temp_q;
    end
    else if(t_s==1 && t_r==0) begin 
      temp_q    =  1;
      temp_qbar = ~temp_q;
    end
    else begin 
      temp_q    = 1'bx;
      temp_qbar = ~temp_q;
    end

    tr.q    = t_q;
    tr.qbar = t_qbar;

    void'(expfifo.try_put(tr));
  endfunction
  //----------------------------------------------------------------------------

  //----------------------------------------------------------------------------
  function void write_mon(sr_sequence_item tr);
    `uvm_info("write_mon OUT ", tr.convert2string(), UVM_MEDIUM)
    void'(outfifo.try_put(tr));
  endfunction
  //----------------------------------------------------------------------------

  //----------------------------------------------------------------------------
  task run_phase(uvm_phase phase);
	sr_sequence_item exp_tr, out_tr;
  static int unsigned count=0;
	forever begin
	    `uvm_info("scoreboard run task","WAITING for expected output", UVM_DEBUG)
	    expfifo.get(exp_tr);
	    `uvm_info("scoreboard run task","WAITING for actual output", UVM_DEBUG)
	    outfifo.get(out_tr);
        
        if (out_tr.q===exp_tr.q && out_tr.qbar===exp_tr.qbar && count>0) begin
            PASS();
          `uvm_info ("\n [ PASS ",out_tr.convert2string() , UVM_MEDIUM)
	      end
      
      	else if (out_tr.q!==exp_tr.q && out_tr.qbar!==exp_tr.qbar && count>0) begin
	         ERROR();
          `uvm_info ("ERROR [ACTUAL_OP]",out_tr.convert2string() , UVM_MEDIUM)
          `uvm_info ("ERROR [EXPECTED_OP]",exp_tr.convert2string() , UVM_MEDIUM)
          `uvm_warning("ERROR",exp_tr.convert2string())
	      end
        count++;
    end
  endtask
  //----------------------------------------------------------------------------

  //----------------------------------------------------------------------------
  function void report_phase(uvm_phase phase);
        super.report_phase(phase);
        if (VECT_CNT && !ERROR_CNT)
            `uvm_info("PASSED",$sformatf("*** TEST PASSED - %0d vectors ran, %0d vectors passed ***",
            VECT_CNT, PASS_CNT), UVM_LOW)

        else
            `uvm_info("FAILED",$sformatf("*** TEST FAILED - %0d vectors ran, %0d vectors passed, %0d vectors failed ***",
            VECT_CNT, PASS_CNT, ERROR_CNT), UVM_LOW)
  endfunction
  //----------------------------------------------------------------------------

  //----------------------------------------------------------------------------
  function void PASS();
	  VECT_CNT++;
	  PASS_CNT++;
  endfunction

  function void ERROR();
  	VECT_CNT++;
  	ERROR_CNT++;
  endfunction
  //----------------------------------------------------------------------------

endclass

