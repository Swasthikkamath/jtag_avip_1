`ifndef JTAGTDIWIDTH8UDR_INCLUDED_
`define JTAGTDIWIDTH8UDR_INCLUDED_

class JtagTdiWidth8UDR extends JtagBaseTest;
  `uvm_component_utils(JtagTdiWidth8UDR)

  extern function new(string name = "JtagTdiWidth8UDR" , uvm_component parent);
  extern virtual function void build_phase(uvm_phase phase);
  extern virtual task run_phase (uvm_phase phase);
endclass : JtagTdiWidth8UDR

function JtagTdiWidth8UDR :: new(string name = "JtagTdiWidth8UDR" , uvm_component parent);
  super.new(name,parent);
endfunction : new

function void JtagTdiWidth8UDR :: build_phase(uvm_phase phase);
  super.build_phase(phase);
  jtagEnvConfig.jtagControllerDeviceAgentConfig.jtagTestVectorWidth = testVectorWidth8Bit;
  jtagEnvConfig.jtagControllerDeviceAgentConfig.jtagInstructionWidth = instructionWidth5Bit;
  jtagEnvConfig.jtagTargetDeviceAgentConfig.jtagTestVectorWidth = testVectorWidth8Bit;
  jtagEnvConfig.jtagTargetDeviceAgentConfig.jtagInstructionWidth = instructionWidth5Bit;
  jtagEnvConfig.jtagControllerDeviceAgentConfig.jtagInstructionOpcode = userDefinedRegister;
  jtagEnvConfig.jtagTargetDeviceAgentConfig.jtagInstructionOpcode = userDefinedRegister;
endfunction : build_phase

task  JtagTdiWidth8UDR :: run_phase(uvm_phase phase);
  jtagVirtualControllerDeviceTestingSequence = JtagVirtualControllerDeviceTestingSequence :: type_id :: create("jtagVirtualControllerDeviceTestingSequence");
  jtagVirtualControllerDeviceTestingSequence.setConfig(jtagEnvConfig.jtagControllerDeviceAgentConfig);
 
  phase.raise_objection(this);
  jtagVirtualControllerDeviceTestingSequence.trstEnable = 'b 0;
  jtagVirtualControllerDeviceTestingSequence.start(jtagEnv.jtagVirtualSequencer);
  jtagVirtualControllerDeviceTestingSequence.trstEnable = 'b 1;
  repeat( NO_OF_TESTS) begin
    jtagVirtualControllerDeviceTestingSequence.start(jtagEnv.jtagVirtualSequencer);
  end
  phase.drop_objection(this);

endtask : run_phase

`endif
