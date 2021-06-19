class sr_sequencer extends uvm_sequencer#(sr_sequence_item);
  //----------------------------------------------------------------------------
  `uvm_component_utils(sr_sequencer)  
  //----------------------------------------------------------------------------

  //----------------------------------------------------------------------------
  function new(string name="sr_sequencer",uvm_component parent);  
    super.new(name,parent);
  endfunction
  //----------------------------------------------------------------------------
  
endclass:sr_sequencer

