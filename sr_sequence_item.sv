class sr_sequence_item extends uvm_sequence_item;

  //------------ i/p || o/p field declaration-----------------

  rand logic  s;  //i/p
  rand logic  r;

  logic q;        //o/p
  logic qbar;
  
  //---------------- register sr_sequence_item class with factory --------
  `uvm_object_utils_begin(sr_sequence_item) 
     `uvm_field_int( r    ,UVM_ALL_ON)
     `uvm_field_int( s    ,UVM_ALL_ON)
     `uvm_field_int( q    ,UVM_ALL_ON)
     `uvm_field_int( qbar ,UVM_ALL_ON)
  `uvm_object_utils_end
  //----------------------------------------------------------------------------

  //----------------------------------------------------------------------------
  function new(string name="sr_sequence_item");
    super.new(name);
  endfunction
  //----------------------------------------------------------------------------

  //----------------------------------------------------------------------------
  // write DUT inputs here for printing
  function string input2string();
    return($sformatf(" s=%0b  r=%0b",s,r));
  endfunction
  
  // write DUT outputs here for printing
  function string output2string();
    return($sformatf(" q=%0b qbar=%0b", q,qbar));
  endfunction
    
  function string convert2string();
    return($sformatf({input2string(), " || ", output2string()}));
  endfunction
  //----------------------------------------------------------------------------

endclass:sr_sequence_item
