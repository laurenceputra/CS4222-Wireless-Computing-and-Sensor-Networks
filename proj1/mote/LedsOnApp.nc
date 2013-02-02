#include "serial_msg.h"

configuration LedsOnApp{
}
implementation {
  components MainC, LedsOn as App, LedsC;
  components new TimerMilliC() as redTimer;
  components new TimerMilliC() as greenTimer;
  components new TimerMilliC() as blueTimer;
  components SerialActiveMessageC as Serial;
  
  App.Boot -> MainC.Boot;
  App.SerialSend -> Serial.AMSend[AM_SERIAL_MSG];
  App.SerialReceive -> Serial.Receive[AM_SERIAL_MSG];
  App.AMControl -> Serial;
  App.Packet -> Serial;
  App.redTimer -> redTimer;
  App.greenTimer -> greenTimer;
  App.blueTimer -> blueTimer;
  App.Leds -> LedsC;
}
