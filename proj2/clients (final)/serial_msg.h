#ifndef SERIAL_MSG
#define SERIAL_MSG

typedef nx_struct serial_msg {
  nx_uint16_t counter;
  nx_uint16_t raw_temp;
  nx_uint16_t raw_humid;
  nx_uint16_t raw_light;
  nx_float temp;
  nx_float humid;
  nx_float light;
}serial_msg_t;

enum {
  AM_SERIAL_MSG = 101,
};

#endif
