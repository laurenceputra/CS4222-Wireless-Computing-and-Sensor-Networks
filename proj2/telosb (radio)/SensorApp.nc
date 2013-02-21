#include "serial_msg.h"
#include "radio_msg.h"
#include "Sampler.h"

configuration SensorApp{}
implementation {
  components Sensor;

  components MainC;
  Sensor.Boot -> MainC.Boot;
  
  components new TimerMilliC() as Timer;
  Sensor.Timer -> Timer;

  components SerialActiveMessageC as Serial;
  Sensor.SerialSend -> Serial.AMSend[AM_SERIAL_MSG];
  Sensor.SerialReceive -> Serial.Receive[AM_SERIAL_MSG];
  Sensor.AMControl -> Serial;
  Sensor.SerialPacket -> Serial;

  components ActiveMessageC as Radio;
  Sensor.RadioSend -> Radio.AMSend[AM_RADIO_MSG];
  Sensor.RadioReceive -> Radio.Receive[AM_RADIO_MSG];
  Sensor.RadioControl -> Radio;
  Sensor.RadioPacket -> Radio;

  components new SensirionSht11C() as TempAndHumid;
  Sensor.Read[unique(UQ_SAMPLER)] -> TempAndHumid.Temperature;
  Sensor.Read[unique(UQ_SAMPLER)] -> TempAndHumid.Humidity;

  components new HamamatsuS10871TsrC() as PhotoTsr;
  Sensor.Read[unique(UQ_SAMPLER)] -> PhotoTsr;
}
