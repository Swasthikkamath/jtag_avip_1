`ifndef JTAGTDIWIDTH24BYPASSREGISTERTEST_INCLUDED_
`define JTAGTDIWIDTH24BYPASSREGISTERTEST_INCLUDED_

class JtagTdiWidth24BypassRegisterTest extends JtagBaseTest;
  `uvm_component_utils(JtagTdiWidth24BypassRegisterTest)

  extern function new(string name = "JtagTdiWidth24BypassRegisterTest" , uvm_component parent);
  extern virtual function void build_phase(uvm_phase phase);
  extern virtual task run_phase (uvm_phase phase);
endclass : JtagTdiWidth24BypassRegisterTest

function JtagTdiWidth24BypassRegisterTest :: new(string name = "JtagTdiWidth24BypassRegisterTest" , uvm_component parent);
  super.new(name,parent);
endfunction : new


function void JtagTdiWidth24BypassRegisterTest :: build_phase(uvm_phase phase);
  super.build_phase(phase);
  jtagEnvConfig.jtagControllerDeviceAgentConfig.jtagTestVectorWidth = testVectorWidth24Bit;
  jtagEnvConfig.jtagControllerDeviceAgentConfig.jtagInstructionWidth = instructionWidth5Bit;
  jtagEnvConfig.jtagTargetDeviceAgentConfig.jtagTestVectorWidth = testVectorWidth24Bit;
  jtagEnvConfig.jtagTargetDeviceAgentConfig.jtagInstructionWidth = instructionWidth5Bit;
  jtagEnvConfig.jtagControllerDeviceAgentConfig.jtagInstructionOpcode = bypassRegister;
  jtagEnvConfig.jtagTargetDeviceAgentConfig.jtagInstructionOpcode = bypassRegister;
endfunction : build_phase

task  JtagTdiWidth24BypassRegisterTest :: run_phase(uvm_phase phase);
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
