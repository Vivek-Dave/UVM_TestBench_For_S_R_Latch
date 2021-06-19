
/***************************************************
** class name  : sr_sequence
** description : generate random input for DUT
***************************************************/
class sr_sequence extends uvm_sequence#(sr_sequence_item);
  //----------------------------------------------------------------------------
  `uvm_object_utils(sr_sequence)            
  //----------------------------------------------------------------------------

  sr_sequence_item txn;
  int unsigned LOOP=50;

  //----------------------------------------------------------------------------
  function new(string name="sr_sequence");  
    super.new(name);
  endfunction
  //----------------------------------------------------------------------------

  //----------------------------------------------------------------------------
  virtual task body();
  repeat(LOOP) begin 
    txn=sr_sequence_item::type_id::create("txn");
    start_item(txn);
    txn.randomize();
    #5;
    finish_item(txn);
  end
  endtask:body
  //----------------------------------------------------------------------------
endclass:sr_sequence

/***************************************************
** class name  : sequence_1
** description : first set and then memory state
***************************************************/
class sequence_1 extends sr_sequence;
  //----------------------------------------------------------------------------   
  `uvm_object_utils(sequence_1)      
  //----------------------------------------------------------------------------
  
  sr_sequence_item txn;
  int unsigned LOOP = 20;
  bit set=1;
  //----------------------------------------------------------------------------
  function new(string name="sequence_1");
      super.new(name);
  endfunction
  //----------------------------------------------------------------------------
  
  //----------------------------------------------------------------------------
  task body();
    for(int i=0;i<LOOP;i++) begin 
    txn=sr_sequence_item::type_id::create("txn");
    start_item(txn);
    txn.randomize()with{txn.s==set;txn.r==0;};
    #5;
    finish_item(txn);
    set=set+1;
  end
  endtask:body
  //----------------------------------------------------------------------------
  
endclass

/***************************************************
** class name  : sequence_2
** description : first reset and then memory state
***************************************************/
class sequence_2 extends sr_sequence;
  //----------------------------------------------------------------------------   
  `uvm_object_utils(sequence_2)      
  //----------------------------------------------------------------------------
  
  sr_sequence_item txn;
  int unsigned LOOP=20;
  bit rst=1;
  
  //----------------------------------------------------------------------------
  function new(string name="sequence_2");
      super.new(name);
  endfunction
  //----------------------------------------------------------------------------
  
  //----------------------------------------------------------------------------
  task body();
    for(int i=0;i<LOOP;i++) begin 
    txn=sr_sequence_item::type_id::create("txn");
    start_item(txn);
      txn.randomize()with{txn.s==0; txn.r==rst;};
    #5;
    finish_item(txn);
    rst=rst+1;
  end
  endtask:body
  //----------------------------------------------------------------------------
  
endclass


/***************************************************
** class name  : sequence_3
** description : first unknown and then memory state
***************************************************/
class sequence_3 extends sr_sequence;
  //----------------------------------------------------------------------------   
  `uvm_object_utils(sequence_3)      
  //----------------------------------------------------------------------------
  
  sr_sequence_item txn;
  int unsigned LOOP=20;
  bit ukn=1;
  //----------------------------------------------------------------------------
  function new(string name="sequence_3");
      super.new(name);
  endfunction
  //----------------------------------------------------------------------------
  
  //----------------------------------------------------------------------------
  task body();
    for(int i=0;i<LOOP;i++) begin 
    txn=sr_sequence_item::type_id::create("txn");
    start_item(txn);
    txn.randomize()with{txn.s==ukn; txn.r==ukn;};
    #5;
    finish_item(txn);
    ukn = ukn + 1;
  end
  endtask:body
  //----------------------------------------------------------------------------
  
endclass

