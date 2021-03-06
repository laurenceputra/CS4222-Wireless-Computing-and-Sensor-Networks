#include "serial_msg.h"
#include "Sampler.h"

configuration SensorApp{}
implementation {
  components MainC;
  components new TimerMilliC() as Timer;
  components SerialActiveMessageC as Serial;
  components new SensirionSht11C() as TempAndHumid,
    new HamamatsuS10871TsrC() as PhotoTsr;
  components Sensor;
  
  Sensor.Boot -> MainC.Boot;
  Sensor.SerialSend -> Serial.AMSend[AM_SERIAL_MSG];
  Sensor.SerialReceive -> Serial.Receive[AM_SERIAL_MSG];
  Sensor.AMControl -> Serial;
  Sensor.Packet -> Serial;
  Sensor.Timer -> Timer;
  Sensor.Read[unique(UQ_SAMPLER)] -> TempAndHumid.Temperature;
  Sensor.Read[unique(UQ_SAMPLER)] -> TempAndHumid.Humidity;
  Sensor.Read[unique(UQ_SAMPLER)] -> PhotoTsr;
}
