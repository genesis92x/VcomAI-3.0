//This function will execute the appropriate code and FSM's onto a group.
//These FSM's will run until the group is cleaned. They will be designed to halt when the group is empty or all units are dead.
_this execFSM "Vcom\FSMS\SQUADBEH.fsm";
VcmAI_ActiveList pushback _this;