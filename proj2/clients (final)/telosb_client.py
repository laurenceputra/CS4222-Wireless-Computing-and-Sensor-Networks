#!/usr/bin/env python

import os,sys,traceback,time
import string
import math
sys.path.append(os.path.join(os.environ["TOSROOT"], "support/sdk/python"))

import tinyos.message.MoteIF as MoteIF
import serial_msg

def main(*args):
  t = serial(args[1], args[2])
  #initialise args grid

class serial():
  def __init__(self, host, port):
    self.mif = MoteIF.MoteIF()
    hostString = "%s%s" % ("sf@", host)
    moteString = "%s:%d" % (hostString, string.atoi(port))
    print(moteString)
    self.source = self.mif.addSource(moteString)
    time.sleep(1)
    self.mif.addListener(self, serial_msg.serial_msg)
    time.sleep(1)

  def send(self, counter, raw_temp, raw_humid, raw_light, temp, humid, light):
      m = serial_msg.serial_msg()
      m.set_counter(counter)
      m.set_raw_temp(raw_temp)
      m.set_raw_humid(raw_humid)
      m.set_raw_light(raw_light)
      m.set_temp(temp)
      m.set_humid(humid)
      m.set_light(light)
      self.mif.sendMsg(self.source, 0x0, m.get_amType(), 0xFF, m)

  def receive(self, src, m): 
    counter = m.get_counter()
    raw_temp = m.get_raw_temp()
    raw_humid = m.get_raw_humid()
    raw_light = m.get_raw_light()
    temp = m.get_temp()
    humid = m.get_humid()
    light = m.get_light()
    print "Packet No Received: ", counter
    print "Raw Temp :", raw_temp
    print "Temp :", temp
    print "Raw Humidity :", raw_humid
    print "Humidity :", humid
    print "Raw Brightness :", raw_light
    print "Brightness :", light

if __name__=='__main__':
 main(*sys.argv)
