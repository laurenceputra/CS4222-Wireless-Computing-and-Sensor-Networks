all: serial_msg.py sbt_serial_msg.py

serial_msg.py: serial_msg.h
	mig python -python-classname=$(@:.py=) $< $(@:.py=) -o $@

sbt_serial_msg.py: sbt_serial_msg.h
	mig python -python-classname=$(@:.py=) $< $(@:.py=) -o $@