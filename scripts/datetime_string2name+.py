from datetime import datetime, timedelta
import sys, re

# StdIn: 'safsdfs datetime=2016:05:09 17:08:31 fsdfdsfs.
# ArgV: Delta Hours
# E.g.: echo 'dewdd32 datetime=2016:05:09 17:08:31 XXX' | python datetime_string2name_and.py -6.75

try:
	delta_hours = float(sys.argv[1])
except:
	delta_hours = 0

strg = re.findall('([0-9]+:[0-9]+:[0-9]+ [0-9]+:[0-9]+:[0-9]+)', sys.stdin.read(), re.DOTALL)[0]

print (datetime.strptime(strg.strip(), '%Y:%m:%d %H:%M:%S') + timedelta(hours=delta_hours)).strftime('%Y%m%d_%H%M%S')
