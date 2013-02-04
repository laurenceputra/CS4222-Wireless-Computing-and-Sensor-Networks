#!/usr/bin/env python

import os,sys,traceback,time
import string

sys.path.append(os.path.join(os.environ["TOSROOT"], "support/sdk/python"))

import tinyos.message.MoteIF as MoteIF
import serial_msg

def main(*args):
  t = serial(args[1], args[2])
  #initialise args grid
  command = []
  for i in range(3):
    command.append([])
    for j in range(2):
      command[i].append(0)
  for i in range(3):
    if len(args) >= i*3 + 5:
      if args[i*3 + 3] == "Red":
        row = 0
      if args[i*3 + 3] == "Green":
        row = 1
      if args[i*3 + 3] == "Blue":
        row = 2
      if args[i*3 + 4] == "On":
        command[row][0] = 1
      else:
        command[row][0] = 2
      command[row][1] = string.atoi(args[i*3 + 5])
  t.send(command[0][0], command[0][1], command[1][0], command[1][1], command[2][0], command[2][1], 0, 0, 0, 0)

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
  
  def send(self, arg1, arg2, arg3, arg4, arg5, arg6, arg7, arg8, arg9, arg10):
	  m = serial_msg.serial_msg()
	  m.set_param_one(arg1)
	  m.set_param_two(arg2)
	  m.set_param_three(arg3)
	  m.set_param_four(arg4)
	  m.set_param_five(arg5)
	  m.set_param_six(arg6)
	  m.set_param_seven(arg7)
	  m.set_param_eight(arg8)
	  m.set_param_nine(arg9)
	  m.set_param_ten(arg10)
	  self.mif.sendMsg(self.source, 0x0, m.get_amType(), 0xFF, m)

  def receive(self, src, m): 
    param_1 = m.get_param_one()
    param_2 = m.get_param_two()
    param_3 = m.get_param_three()
    param_4 = m.get_param_four()
    param_5 = m.get_param_five()
    param_6 = m.get_param_six()
    param_7 = m.get_param_seven()
    param_8 = m.get_param_eight()
    param_9 = m.get_param_nine()
    param_10 = m.get_param_ten()
    print "Packet No Received: ", param_1
    if param_2 == 1:
      print "Red LED lights up for", param_3, "seconds"
    if param_4 == 1:
      print "Green LED lights up for", param_5, "seconds"
    if param_6 == 1:
      print "Blue LED lights up for", param_7, "seconds"

if __name__=='__main__':
 main(*sys.argv)
