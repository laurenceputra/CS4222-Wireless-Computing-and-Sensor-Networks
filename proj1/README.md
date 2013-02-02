#Client

Code is in the folder client/

Command is in the format

    ./client/client.py 127.0.0.1 8888 Blue On 8 Green On 2 Red On 3

User has to specify the colour first, followed by On or Off, followed by an integer to represent the time in seconds

Accepted values for colour is "Red", "Blue", "Green"

Accepted values for state is "On" and "Off"

Accepted values for time is any 8 bit integer to represent the number of seconds.

*Note: The order of the colour can be alternated. For example

    ./client/client.py 127.0.0.1 8888 Blue On 8 Red On 3 Green On 2

does the same thing as the command above. In addition, should you not choose to light up one LED, you need not specify it's state.

For example

    ./client/client.py 127.0.0.1 8888 Blue On 8 Red On 3

The serial forwarder is required to be on, and in this case, listening to port 8888.

#Mote

Code is in the folder mote/

To compile and load the program onto the mote, simply enter the following command

    make clean; make telosb;make telosb reinstall.1 bsl,/dev/ttyUSB1

*Note change /dev/ttyUSB1 to whichever device your mote is on