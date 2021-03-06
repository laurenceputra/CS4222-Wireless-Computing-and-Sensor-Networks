#ifndef SERIAL_MSG
#define SERIAL_MSG

typedef nx_struct serial_msg {
  nx_uint16_t param_one;
  nx_uint16_t param_two;
  nx_uint16_t param_three;
  nx_uint16_t param_four;
  nx_float param_five;
  nx_float param_six;
  nx_float param_seven;
  nx_uint16_t param_eight;
  nx_uint16_t param_nine;
  nx_uint16_t param_ten;
}serial_msg_t;

enum {
  AM_SERIAL_MSG = 101,
};

#endif
