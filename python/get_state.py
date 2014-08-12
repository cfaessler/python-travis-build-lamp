#! /usr/bin/python

from __future__ import print_function

import requests
import serial
import time
import sys


# Interval travis ci status is polled in seconds
query_interval = 60
device = '/dev/ttyUSB0'
travis_urls = ["http://api.travis-ci.org/repos/strongswan/strongTNC",
               "http://api.travis-ci.org/repos/strongswan/swidGenerator",
		"http://api.travis-ci.org/repos/latin-language-toolkit/arethusa"]

# Time to settle
time.sleep(3)
serial_port = serial.Serial(device, 9600)
serial_port.setDTR(False)

def print_status(message):
    time_string = time.strftime("%H:%M:%S")
    print("[{0}]: {1}".format(time_string, message))


while True:
    try:
        build_failed = False
        for repo in travis_urls:
            print_status("Querying  Repository %s..." % repo)
            response = requests.get(repo)
            data = response.json()
            last_result = data['last_build_result']

            if last_result == 0:
                print_status("Last build of %s was sucessfull!" % repo)
            else:
                print_status("Last build if %s failed" % repo)
                build_failed = True

        serial_port.setDTR(build_failed)
        time.sleep(query_interval)

    except KeyboardInterrupt:
        print_status("Goodbye...")
        serial_port.close()
        sys.exit(0)
