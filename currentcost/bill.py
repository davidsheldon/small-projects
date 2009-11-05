#!/usr/bin/python

import time
import sys



def processLine(s):
	global lastTime, total 
	array = s.split()
	power = int(array[3])
	temp = float(array[4])
	date = time.mktime(time.strptime("%s %s" % (array[0], array[1]), "%Y-%m-%d %H:%M:%S"))

	if lastTime != 0:
	  this = (date-lastTime) * power
	  total += this
	  #print "%d %d %d %.3f" % (date, this, total, (total / (60.0 * 60.0 * 1000.0)))
	  
	lastTime = date


total = 0
lastTime = 0
for line in sys.stdin:
	processLine(line)

print "%.3f kwh total used" % (total / (60.0 * 60.0 * 1000.0))
