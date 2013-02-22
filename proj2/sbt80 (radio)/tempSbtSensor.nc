module SbtSensor {
  uses {
    interface Boot;

    //Serial
    interface AMSend as SerialSend;
    interface Receive as SerialReceive;
    interface SplitControl as AMControl;
    interface Packet as SerialPacket;

    //Radio
    interface AMSend as RadioSend;
    interface Receive as RadioReceive;
    interface SplitControl as RadioControl;
    interface Packet as RadioPacket;
    
    //SBT stuff
    interface HplMsp430GeneralIO as SBswitch;
    interface HplMsp430GeneralIO as SBcontrol;
    interface Read<uint16_t> as Light;
    interface Read<uint16_t> as Temp;
  }
}
implementation {

  message_t sPacket, rPacket;
  sbt_serial_msg_t* rcm;
  radio_msg_t* radiomsg;
  bool locked;
  uint8_t counter = 0;
  uint16_t temp = 0;
  uint16_t light = 0;
  float real_temp = 0;
  float real_light = 0;

  event void Boot.booted() {
    call AMControl.start();
    call RadioControl.start();
    rcm = (sbt_serial_msg_t *)call SerialPacket.getPayload(&sPacket, sizeof(sbt_serial_msg_t));
    radiomsg = (radio_msg_t *)call RadioPacket.getPayload(&rPacket, sizeof(radio_msg_t));
  }

  void sendMessage()
  {
    if (locked) {
      return;
    }
    else {
      if (rcm == NULL) {
        return;
      }
      counter++;
      rcm->counter = counter;
      
      if (call SerialSend.send(126, &sPacket, sizeof(sbt_serial_msg_t)) == SUCCESS) {
        locked = TRUE;
      }
    }
  }

  event void AMControl.startDone(error_t err) {
    if (err == SUCCESS) {
      sendMessage();
      //do nothing
    }
    else {
      call AMControl.start();
    }
  }

  event void AMControl.stopDone(error_t err) {
    // do nothing
  }

  event void RadioControl.startDone(error_t err) {
    if (err == SUCCESS) {
      //do nothing
    }
    else {
      call RadioControl.start();
    }
  }

  event void RadioControl.stopDone(error_t err) {
    // do nothing
  }

  event void SerialSend.sendDone(message_t* bufPtr, error_t error)
  {
    locked = FALSE;
  }

  event void RadioSend.sendDone(message_t* bufPtr, error_t error){
  }

  event message_t* SerialReceive.receive(message_t* bufPtr, void* payload, uint8_t len)
  {
    return bufPtr;
  }
  event message_t* RadioReceive.receive(message_t* bufPtr, void* payload, uint8_t len)
  {
    radiomsg = (radio_msg_t*)payload;
    rcm->telosb_temp = radiomsg->param_two;
    rcm->telosb_humid = radiomsg->param_three;
    rcm->telosb_light = radiomsg->param_four;
    call Light.read();
    return bufPtr;
  }
  
  event void Light.readDone(error_t result, uint16_t val){
    rcm->sbt_light = val;
    call Temp.read();
  }

  event void Temp.readDone(error_t result, uint16_t val){
    rcm->sbt_temp = val;
    sendMessage();
  }
}
