#ifndef SAMPLER_H
#define SAMPLER_H

#define INVALID_SAMPLE_VALUE 0xFFFF
#define UQ_SAMPLER "Sampler"

uint32_t SAMPLE_INTERVAL = 1*1024; // How often to sample sensors

typedef nx_struct Entry {
  nx_uint32_t counter;
  nx_uint16_t values[3];
} Entry;

enum {
  SENSORS_NO = 3,   // Total number of sensors
  RETRY_NO = 3,   // Total number of retries before declaring operation failure
};

#endif
