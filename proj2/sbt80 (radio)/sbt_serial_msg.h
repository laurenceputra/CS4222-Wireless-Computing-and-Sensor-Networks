#ifndef SBT_SERIAL_MSG
#define SBT_SERIAL_MSG

typedef nx_struct sbt_serial_msg {
  nx_uint16_t counter;
  nx_float telosb_temp;
  nx_float telosb_humid;
  nx_float telosb_light;
  nx_float sbt_temp;
  nx_float sbt_light;
}sbt_serial_msg_t;

enum {
  AM_SBT_SERIAL_MSG = 102,
};

#endif
