#include "serial_msg.h"
#include "radio_msg.h"
#include "Sampler.h"

configuration SbtSensorApp{}
implementation {
  components SbtSensor;

  components MainC;
  SbtSensor.Boot -> MainC.Boot;
  
  components new TimerMilliC() as Timer;
  SbtSensor.Timer -> Timer;

  components SerialActiveMessageC as Serial;
  SbtSensor.SerialSend -> Serial.AMSend[AM_SERIAL_MSG];
  SbtSensor.SerialReceive -> Serial.Receive[AM_SERIAL_MSG];
  SbtSensor.AMControl -> Serial;
  SbtSensor.SerialPacket -> Serial;

  components ActiveMessageC as Radio;
  SbtSensor.RadioSend -> Radio.AMSend[AM_RADIO_MSG];
  SbtSensor.RadioReceive -> Radio.Receive[AM_RADIO_MSG];
  SbtSensor.RadioControl -> Radio;
  SbtSensor.RadioPacket -> Radio;

  components new SBT80_ADCconfigC() as Light;
  components new SBT80_ADCconfigC() as Temp;
  SbtSensor.Light -> Light.ReadADC0;
  SbtSensor.Temperature -> Temp.ReadADC3;
}
