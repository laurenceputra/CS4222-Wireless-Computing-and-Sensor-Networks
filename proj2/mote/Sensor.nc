module Sensor {
  uses {
    interface Boot;
    interface AMSend as SerialSend;
        interface Receive as SerialReceive;
    interface SplitControl as AMControl;
    interface Timer<TMilli> as Timer;
    interface Packet;
    interface Read<uint16_t>[uint8_t id];
  }
}
implementation {

  message_t packet;
  bool locked;
  uint8_t counter = 0;
  uint8_t sensor_no = 0;
  uint16_t temp = 0;
  uint16_t humid = 0;
  uint16_t light = 0;
  Entry* readings;

  event void Boot.booted() {
    call AMControl.start();
  }

  event void AMControl.startDone(error_t err) {
    if (err == SUCCESS) {
      call Timer.startOneShot(SAMPLE_INTERVAL);
    }
    else {
      call AMControl.start();
    }
  }

  event void AMControl.stopDone(error_t err) {
    // do nothing
  }

  void sendMessage()
  {
    if (locked) {
      return;
    }
    else {
      serial_msg_t* rcm = (serial_msg_t *)call Packet.getPayload(&packet, sizeof(serial_msg_t));
      if (rcm == NULL) {
        return;
      }
      counter++;
      rcm->param_one = counter;
      rcm->param_two = temp;
      rcm->param_three = humid;
      rcm->param_four = light;
      if (call SerialSend.send(126, &packet, sizeof(serial_msg_t)) == SUCCESS) {
        locked = TRUE;
      }
    }
    call Timer.startOneShot(SAMPLE_INTERVAL);
  }

  void sample_sensors(){
    call Read.read[0]();
  }

  event void Timer.fired(){
    sensor_no = 0;
    sample_sensors();
  }

  event void SerialSend.sendDone(message_t* bufPtr, error_t error)
  {
    locked = FALSE;
  }

  event void Read.readDone[uint8_t id](error_t error, uint16_t val){
    if(id == 0){
      temp = val;
    }
    else if(id == 1){
      humid = val;
    }
    else if(id == 2){
      light = val;
    }
    sensor_no++;
    if(sensor_no < SENSORS_NO){
      call Read.read[sensor_no]();
    }
    else{
      sendMessage();
    }
  }

  event message_t* SerialReceive.receive(message_t* bufPtr, void* payload, uint8_t len)
  {
    return bufPtr;
  }
   default command error_t Read.read[uint8_t id]() { return FAIL; }
}
