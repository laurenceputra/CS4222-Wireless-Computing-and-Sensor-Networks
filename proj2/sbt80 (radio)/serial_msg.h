#ifndef SERIAL_MSG
#define SERIAL_MSG

typedef nx_struct serial_msg {
  nx_uint16_t param_one;
  nx_float param_two;
  nx_float param_three;
  nx_float param_four;
  nx_float param_five;
  nx_float param_six;
  nx_float param_seven;
}serial_msg_t;

enum {
  AM_SERIAL_MSG = 101,
};

#endif
