
class sr_test extends uvm_test;

    //--------------------------------------------------------------------------
    `uvm_component_utils(sr_test)
    //--------------------------------------------------------------------------

    //--------------------------------------------------------------------------
    function new(string name="sr_test",uvm_component parent);
	   super.new(name,parent);
    endfunction
    //--------------------------------------------------------------------------

    sr_env env_h;
    int file_h;

    //--------------------------------------------------------------------------
    function void build_phase(uvm_phase phase);
      super.build_phase(phase);
      env_h = sr_env::type_id::create("env_h",this);
    endfunction
    //--------------------------------------------------------------------------

    //--------------------------------------------------------------------------
    function void end_of_elobartion_phase(uvm_phase phase);
      //factory.print();
      $display("End of eleboration phase in agent");
    endfunction
    //--------------------------------------------------------------------------

    //--------------------------------------------------------------------------
    function void start_of_simulation_phase(uvm_phase phase);
      $display("start_of_simulation_phase");
      file_h=$fopen("LOG_FILE.log","w");
      set_report_default_file_hier(file_h);
      set_report_severity_action_hier(UVM_INFO,UVM_DISPLAY+UVM_LOG);
      set_report_verbosity_level_hier(UVM_MEDIUM);
    endfunction
    //--------------------------------------------------------------------------

    //--------------------------------------------------------------------------
    task run_phase(uvm_phase phase);
        sr_sequence seq;
        sequence_1 seq1;
        sequence_2 seq2;
        sequence_3 seq3;
	      phase.raise_objection(this);
            
            seq = sr_sequence::type_id::create("seq");
            seq1= sequence_1::type_id::create("seq1");
            seq2= sequence_2::type_id::create("se2");
            seq3= sequence_3::type_id::create("se3");

            seq.start(env_h.agent_h.sequencer_h);
            seq1.start(env_h.agent_h.sequencer_h);
            seq2.start(env_h.agent_h.sequencer_h);
            seq3.start(env_h.agent_h.sequencer_h);

            #10;
	      phase.drop_objection(this);
    endtask
    //--------------------------------------------------------------------------

endclass:sr_test

