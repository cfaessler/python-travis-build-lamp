python-travis-build-lamp
========================

Installation
------------

Get code & install dependencies


    $ git clone http://github.com/cfaessler/python-travis-build-lamp
    $ aptitude install python-pip
    $ cd python-travis-build-lamp
    $ pip install -r python/requirements.txt

Setup init script

    $ sudo chmod 755 python/get_state.py
    $ sudo chmod 755 build_lamp.sh
    $ ln -s python/get_state.py /usr/local/bin/build_lamp_loop.py
    $ ln -s build_lamp.sh /etc/init.d/BuildLamp
    $ update-rc.d BuildLamp defaults

Start Service
-------------
    $ service BuildLamp start
    
Stop Service
------------
    $ service BuildLamp stop

Delete init script
------------------
    $ update-rc.d -f BuildLamp remove

