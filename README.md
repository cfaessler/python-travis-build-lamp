python-travis-build-lamp
========================

Installation
------------

Get code & install dependencies


    $ git clone http://github.com/cfaessler/python-travis-build-lamp
    $ aptitude install python-pip
    $ pip install -r python/requirements.txt

Setup init script

    $ sudo chmod 755 python-travis-build_lamp/python/get_state.py
    $ sudo chmod 755 python-travis-build_lamp/build_lamp.sh
    $ ln -s python-travis-build-lamp/python/get_state.py /usr/local/bin/build_lamp_loop.py
    $ ln -s python-travis-build-lamp/build_lamp.sh /etc/init.d/BuildLamp.sh
    $ update-rc.d BuildLamp.sh defaults

Start Service
-------------
    $ service BuildLamp.sh start
    
Stop Service
------------
    $ service BuildLamp.sh stop

Delete init script
------------------
    $ update-rc.d -f BuildLamp.sh remove

