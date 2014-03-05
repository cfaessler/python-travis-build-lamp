#! /usr/bin/python

from __future__ import print_function

import requests
import serial
import time
import sys


# Interval travis ci status is polled in seconds
query_interval = 60
port_device = '/dev/ttyACM0'
travis_url = "http://api.travis-ci.org/repos/tnc-ba/strongTNC"

# Time to settle
time.sleep(3)
serial_port = serial.Serial(port_device, 9600)

def print_status(message):
    time_string = time.strftime("%H:%M:%S")
    print("[{0}]: {1}".format(time_string, message))


while True:
    try:
        print_status("Querying  Travis CI...")
        response = requests.get(travis_url)
        data = response.json()
        last_result = data['last_build_result']

        if last_result == 0:
            print_status("Last build was sucessfull!")
            serial_port.write("off\r")
        else:
            print_status("Last build failed")
            serial_port.write("on\r")

        time.sleep(query_interval)

    except KeyboardInterrupt:
		print_status("Goodbye...")
		serial_port.close()
		sys.exit(0)
