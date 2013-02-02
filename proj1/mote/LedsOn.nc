#include "Timer.h"
 
module LedsOn {
  uses {
    interface Leds;
    interface Boot;
    interface AMSend as SerialSend;
		interface Receive as SerialReceive;
    interface SplitControl as AMControl;
    interface Timer<TMilli> as redTimer;
    interface Timer<TMilli> as greenTimer;
    interface Timer<TMilli> as blueTimer;
    interface Packet;
  }
}
implementation {

  message_t packet;

  bool locked;
  uint32_t counter = 0;

  event void Boot.booted() {
    call AMControl.start();
  }

  event void AMControl.startDone(error_t err) {
    if (err == SUCCESS) {
      //do nothing
    }
    else {
      call AMControl.start();
    }
  }

  event void AMControl.stopDone(error_t err) {
    // do nothing
  }

  void sendMessage(uint8_t red, uint8_t redTime, uint8_t green, uint8_t greenTime, uint8_t blue, uint8_t blueTime)
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
      rcm->param_one=counter;
      rcm->param_two = red;
      rcm->param_three = redTime;
      rcm->param_four = green;
      rcm->param_five = greenTime;
      rcm->param_six = blue;
      rcm->param_seven = blueTime;
      if (call SerialSend.send(126, &packet, sizeof(serial_msg_t)) == SUCCESS) {
        locked = TRUE;
      }
    }
  }

  event void SerialSend.sendDone(message_t* bufPtr, error_t error)
  {
    locked = FALSE;
  }

  event void redTimer.fired(){
    call Leds.led0Off();
  }

  event void greenTimer.fired(){
    call Leds.led1Off();
  }

  event void blueTimer.fired(){
    call Leds.led2Off();
  }
	
	event message_t* SerialReceive.receive(message_t* bufPtr, void* payload, uint8_t len)
	{
		serial_msg_t* rcm = (serial_msg_t *)(payload);
		if(rcm->param_one == 1) {
			call Leds.led0On();
      call redTimer.startOneShot(rcm->param_two * 1024);
		}
    if(rcm->param_three == 1) {
      call Leds.led1On();
      call greenTimer.startOneShot(rcm->param_four * 1024);
    }
    if(rcm->param_five == 1) {
      call Leds.led2On();
      call blueTimer.startOneShot(rcm->param_six * 1024);
    }
    sendMessage(rcm->param_one, rcm->param_two, rcm->param_three, rcm->param_four, rcm->param_five, rcm->param_six);
		return bufPtr;
	}
}
