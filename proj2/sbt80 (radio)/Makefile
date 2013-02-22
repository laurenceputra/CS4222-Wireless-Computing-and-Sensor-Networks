COMPONENT=SbtSensorApp
BUILD_EXTRA_DEPS += sbt_serial_msg.java

sbt_serial_msg.java: sbt_serial_msg.h
	mig java -java-classname=blah.foo.$(@:.java=) $< $(@:.java=) -o $@

include $(MAKERULES)

