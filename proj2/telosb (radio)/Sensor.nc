module Sensor {
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

    interface Timer<TMilli> as Timer;
    
    interface Read<uint16_t>[uint8_t id];
  }
}
implementation {

  message_t sPacket, rPacket;
  serial_msg_t* rcm;
  radio_msg_t* radiomsg;
  bool locked, lockedRadio, serialReady = FALSE, radioReady = FALSE;
  uint8_t counter = 0;
  uint8_t counterRadio = 0;
  uint8_t sensor_no = 0;
  uint16_t temp = 0;
  uint16_t humid = 0;
  uint16_t light = 0;
  float real_temp = 0;
  float real_humid = 0;
  float real_light = 0;

  event void Boot.booted() {
    call AMControl.start();
    call RadioControl.start();
    rcm = (serial_msg_t *)call SerialPacket.getPayload(&sPacket, sizeof(serial_msg_t));
    radiomsg = (radio_msg_t *)call RadioPacket.getPayload(&rPacket, sizeof(radio_msg_t));
    call Timer.startOneShot(SAMPLE_INTERVAL);
  }

  event void AMControl.startDone(error_t err) {
    if (err == SUCCESS) {
      serialReady = TRUE;
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
      radioReady = TRUE;
    }
    else {
      call RadioControl.start();
    }
  }

  event void RadioControl.stopDone(error_t err) {
    // do nothing
  }

  void sendRadioMessage(){
    if(lockedRadio) {
      return;
    }
    else {
      if(radiomsg == NULL){
        return;
      }
      counterRadio++;
      radiomsg->param_one = counter;
      radiomsg->param_two = real_temp;
      radiomsg->param_three = real_humid;
      radiomsg->param_four = real_light;
      if (call RadioSend.send(AM_BROADCAST_ADDR, &rPacket, sizeof(radio_msg_t)) == SUCCESS){
        lockedRadio = TRUE;
      }
    }

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
      real_temp = -39.6 + (0.01 * temp);
      real_humid = (real_temp - 25) * (0.01 + 0.00008 * humid) -4 + (0.0405 * humid) + (-0.0000028 * humid * humid);
      real_light = 0.28161 * light;

      rcm->param_one = counter;
      rcm->param_two = temp;
      rcm->param_three = humid;
      rcm->param_four = light;
      rcm->param_five = real_temp;
      rcm->param_six = real_humid;
      rcm->param_seven = real_light;
      if (call SerialSend.send(126, &sPacket, sizeof(serial_msg_t)) == SUCCESS) {
        locked = TRUE;
      }
    }
  }

  void sample_sensors(){
    call Read.read[0]();
  }

  event void Timer.fired(){
    if(serialReady && radioReady){
      sensor_no = 0;
      sample_sensors();
    }
  }

  event void SerialSend.sendDone(message_t* bufPtr, error_t error)
  {
    locked = FALSE;
    sendRadioMessage();
  }

  event void RadioSend.sendDone(message_t* bufPtr, error_t error){
    lockedRadio = FALSE;
    call Timer.startOneShot(SAMPLE_INTERVAL);
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
  event message_t* RadioReceive.receive(message_t* bufPtr, void* payload, uint8_t len)
  {
    return bufPtr;
  }
  default command error_t Read.read[uint8_t id]() { return FAIL; }
}
