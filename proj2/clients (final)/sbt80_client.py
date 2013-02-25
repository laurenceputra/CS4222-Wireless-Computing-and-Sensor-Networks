#!/usr/bin/env python

import os,sys,traceback,time
import string
import math
sys.path.append(os.path.join(os.environ["TOSROOT"], "support/sdk/python"))

import tinyos.message.MoteIF as MoteIF
import sbt_serial_msg

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
    self.mif.addListener(self, sbt_serial_msg.sbt_serial_msg)
    time.sleep(1)
  
  def send(self, counter, telosb_temp, telosb_humid, telosb_light, sbt_temp, sbt_light):
      m = sbt_serial_msg.sbt_serial_msg()
      m.set_counter(counter)
      m.set_telosb_temp(telosb_temp)
      m.set_telosb_humid(telosb_humid)
      m.set_ptelosb_light(telosb_light)
      m.set_sbt_temp(sbt_temp)
      m.set_sbt_light(sbt_light)
      self.mif.sendMsg(self.source, 0x0, m.get_amType(), 0xFF, m)

  def receive(self, src, m): 
    counter = m.get_counter()
    telosb_temp = m.get_telosb_temp()
    telosb_humid = m.get_telosb_humid()
    telosb_light = m.get_telosb_light()
    sbt_temp = m.get_sbt_temp()
    sbt_light = m.get_sbt_light()
    print "Packet No Received : ", counter
    print "TelosB temp        :", telosb_temp
    print "TelosB humidity    :", telosb_humid
    print "TelosB light       :", telosb_light
    print "Sbt80 temp         :", sbt_temp
    print "Sbt80 light        :", sbt_light

if __name__=='__main__':
 main(*sys.argv)
