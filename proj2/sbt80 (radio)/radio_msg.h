#ifndef RADIO_MSG
#define RADIO_MSG

typedef nx_struct RADIO_MSG {
  nx_uint16_t param_one;
  nx_float param_two;
  nx_float param_three;
  nx_float param_four;
}radio_msg_t;

enum {
  AM_RADIO_MSG = 101,
};

#endif
