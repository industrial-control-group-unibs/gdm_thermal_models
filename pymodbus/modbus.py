import minimalmodbus
import time
import matplotlib.pyplot as plt

#PORT='/dev/ttyUSB1'
PORT='COM6'
VEL_REGISTER = 0x100
ACC_REGISTER = 0x104
TOR_REGISTER = 0x102
MAX_CUR_REGISTER = 0x1011
ENCODER_VEL_REGISTER = 0x2214
ENCODER_POS_REGISTER = 0x1002
DIRECTION_REGISTER = 0x0000

#Set up instrument
instrument = minimalmodbus.Instrument(PORT,1,debug=True)

#Make the settings explicit
instrument.serial.baudrate = 38400 # Baud
instrument.serial.bytesize = 8
instrument.serial.parity   = minimalmodbus.serial.PARITY_NONE
instrument.serial.stopbits = 1
instrument.serial.timeout  = 1          # seconds

# Good practice
instrument.close_port_after_each_call = False

instrument.clear_buffers_before_each_transaction = True

position  = instrument.read_register(12022)
instrument.write_float(11000,20.0)
        