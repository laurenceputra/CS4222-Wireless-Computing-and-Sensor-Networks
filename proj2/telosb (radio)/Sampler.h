#ifndef SAMPLER_H
#define SAMPLER_H

#define INVALID_SAMPLE_VALUE 0xFFFF
#define UQ_SAMPLER "Sampler"

uint32_t SAMPLE_INTERVAL = 5*1024; // How often to sample sensors

enum {
  SENSORS_NO = uniqueCount("Sampler"),   // Total number of sensors
  RETRY_NO = 3,   // Total number of retries before declaring operation failure
};

#endif
