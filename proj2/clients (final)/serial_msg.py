#
# This class is automatically generated by mig. DO NOT EDIT THIS FILE.
# This class implements a Python interface to the 'serial_msg'
# message type.
#

import tinyos.message.Message

# The default size of this message type in bytes.
DEFAULT_MESSAGE_SIZE = 20

# The Active Message type associated with this message.
AM_TYPE = 101

class serial_msg(tinyos.message.Message.Message):
    # Create a new serial_msg of size 20.
    def __init__(self, data="", addr=None, gid=None, base_offset=0, data_length=20):
        tinyos.message.Message.Message.__init__(self, data, addr, gid, base_offset, data_length)
        self.amTypeSet(AM_TYPE)
    
    # Get AM_TYPE
    def get_amType(cls):
        return AM_TYPE
    
    get_amType = classmethod(get_amType)
    
    #
    # Return a String representation of this message. Includes the
    # message type name and the non-indexed field values.
    #
    def __str__(self):
        s = "Message <serial_msg> \n"
        try:
            s += "  [counter=0x%x]\n" % (self.get_counter())
        except:
            pass
        try:
            s += "  [raw_temp=0x%x]\n" % (self.get_raw_temp())
        except:
            pass
        try:
            s += "  [raw_humid=0x%x]\n" % (self.get_raw_humid())
        except:
            pass
        try:
            s += "  [raw_light=0x%x]\n" % (self.get_raw_light())
        except:
            pass
        try:
            s += "  [temp=%f]\n" % (self.get_temp())
        except:
            pass
        try:
            s += "  [humid=%f]\n" % (self.get_humid())
        except:
            pass
        try:
            s += "  [light=%f]\n" % (self.get_light())
        except:
            pass
        return s

    # Message-type-specific access methods appear below.

    #
    # Accessor methods for field: counter
    #   Field type: int
    #   Offset (bits): 0
    #   Size (bits): 16
    #

    #
    # Return whether the field 'counter' is signed (True).
    #
    def isSigned_counter(self):
        return True
    
    #
    # Return whether the field 'counter' is an array (False).
    #
    def isArray_counter(self):
        return False
    
    #
    # Return the offset (in bytes) of the field 'counter'
    #
    def offset_counter(self):
        return (0 / 8)
    
    #
    # Return the offset (in bits) of the field 'counter'
    #
    def offsetBits_counter(self):
        return 0
    
    #
    # Return the value (as a int) of the field 'counter'
    #
    def get_counter(self):
        return self.getUIntElement(self.offsetBits_counter(), 16, 1)
    
    #
    # Set the value of the field 'counter'
    #
    def set_counter(self, value):
        self.setUIntElement(self.offsetBits_counter(), 16, value, 1)
    
    #
    # Return the size, in bytes, of the field 'counter'
    #
    def size_counter(self):
        return (16 / 8)
    
    #
    # Return the size, in bits, of the field 'counter'
    #
    def sizeBits_counter(self):
        return 16
    
    #
    # Accessor methods for field: raw_temp
    #   Field type: int
    #   Offset (bits): 16
    #   Size (bits): 16
    #

    #
    # Return whether the field 'raw_temp' is signed (True).
    #
    def isSigned_raw_temp(self):
        return True
    
    #
    # Return whether the field 'raw_temp' is an array (False).
    #
    def isArray_raw_temp(self):
        return False
    
    #
    # Return the offset (in bytes) of the field 'raw_temp'
    #
    def offset_raw_temp(self):
        return (16 / 8)
    
    #
    # Return the offset (in bits) of the field 'raw_temp'
    #
    def offsetBits_raw_temp(self):
        return 16
    
    #
    # Return the value (as a int) of the field 'raw_temp'
    #
    def get_raw_temp(self):
        return self.getUIntElement(self.offsetBits_raw_temp(), 16, 1)
    
    #
    # Set the value of the field 'raw_temp'
    #
    def set_raw_temp(self, value):
        self.setUIntElement(self.offsetBits_raw_temp(), 16, value, 1)
    
    #
    # Return the size, in bytes, of the field 'raw_temp'
    #
    def size_raw_temp(self):
        return (16 / 8)
    
    #
    # Return the size, in bits, of the field 'raw_temp'
    #
    def sizeBits_raw_temp(self):
        return 16
    
    #
    # Accessor methods for field: raw_humid
    #   Field type: int
    #   Offset (bits): 32
    #   Size (bits): 16
    #

    #
    # Return whether the field 'raw_humid' is signed (True).
    #
    def isSigned_raw_humid(self):
        return True
    
    #
    # Return whether the field 'raw_humid' is an array (False).
    #
    def isArray_raw_humid(self):
        return False
    
    #
    # Return the offset (in bytes) of the field 'raw_humid'
    #
    def offset_raw_humid(self):
        return (32 / 8)
    
    #
    # Return the offset (in bits) of the field 'raw_humid'
    #
    def offsetBits_raw_humid(self):
        return 32
    
    #
    # Return the value (as a int) of the field 'raw_humid'
    #
    def get_raw_humid(self):
        return self.getUIntElement(self.offsetBits_raw_humid(), 16, 1)
    
    #
    # Set the value of the field 'raw_humid'
    #
    def set_raw_humid(self, value):
        self.setUIntElement(self.offsetBits_raw_humid(), 16, value, 1)
    
    #
    # Return the size, in bytes, of the field 'raw_humid'
    #
    def size_raw_humid(self):
        return (16 / 8)
    
    #
    # Return the size, in bits, of the field 'raw_humid'
    #
    def sizeBits_raw_humid(self):
        return 16
    
    #
    # Accessor methods for field: raw_light
    #   Field type: int
    #   Offset (bits): 48
    #   Size (bits): 16
    #

    #
    # Return whether the field 'raw_light' is signed (True).
    #
    def isSigned_raw_light(self):
        return True
    
    #
    # Return whether the field 'raw_light' is an array (False).
    #
    def isArray_raw_light(self):
        return False
    
    #
    # Return the offset (in bytes) of the field 'raw_light'
    #
    def offset_raw_light(self):
        return (48 / 8)
    
    #
    # Return the offset (in bits) of the field 'raw_light'
    #
    def offsetBits_raw_light(self):
        return 48
    
    #
    # Return the value (as a int) of the field 'raw_light'
    #
    def get_raw_light(self):
        return self.getUIntElement(self.offsetBits_raw_light(), 16, 1)
    
    #
    # Set the value of the field 'raw_light'
    #
    def set_raw_light(self, value):
        self.setUIntElement(self.offsetBits_raw_light(), 16, value, 1)
    
    #
    # Return the size, in bytes, of the field 'raw_light'
    #
    def size_raw_light(self):
        return (16 / 8)
    
    #
    # Return the size, in bits, of the field 'raw_light'
    #
    def sizeBits_raw_light(self):
        return 16
    
    #
    # Accessor methods for field: temp
    #   Field type: float
    #   Offset (bits): 64
    #   Size (bits): 32
    #

    #
    # Return whether the field 'temp' is signed (True).
    #
    def isSigned_temp(self):
        return True
    
    #
    # Return whether the field 'temp' is an array (False).
    #
    def isArray_temp(self):
        return False
    
    #
    # Return the offset (in bytes) of the field 'temp'
    #
    def offset_temp(self):
        return (64 / 8)
    
    #
    # Return the offset (in bits) of the field 'temp'
    #
    def offsetBits_temp(self):
        return 64
    
    #
    # Return the value (as a float) of the field 'temp'
    #
    def get_temp(self):
        return self.getFloatElement(self.offsetBits_temp(), 32, 0)
    
    #
    # Set the value of the field 'temp'
    #
    def set_temp(self, value):
        self.setFloatElement(self.offsetBits_temp(), 32, value, 0)
    
    #
    # Return the size, in bytes, of the field 'temp'
    #
    def size_temp(self):
        return (32 / 8)
    
    #
    # Return the size, in bits, of the field 'temp'
    #
    def sizeBits_temp(self):
        return 32
    
    #
    # Accessor methods for field: humid
    #   Field type: float
    #   Offset (bits): 96
    #   Size (bits): 32
    #

    #
    # Return whether the field 'humid' is signed (True).
    #
    def isSigned_humid(self):
        return True
    
    #
    # Return whether the field 'humid' is an array (False).
    #
    def isArray_humid(self):
        return False
    
    #
    # Return the offset (in bytes) of the field 'humid'
    #
    def offset_humid(self):
        return (96 / 8)
    
    #
    # Return the offset (in bits) of the field 'humid'
    #
    def offsetBits_humid(self):
        return 96
    
    #
    # Return the value (as a float) of the field 'humid'
    #
    def get_humid(self):
        return self.getFloatElement(self.offsetBits_humid(), 32, 0)
    
    #
    # Set the value of the field 'humid'
    #
    def set_humid(self, value):
        self.setFloatElement(self.offsetBits_humid(), 32, value, 0)
    
    #
    # Return the size, in bytes, of the field 'humid'
    #
    def size_humid(self):
        return (32 / 8)
    
    #
    # Return the size, in bits, of the field 'humid'
    #
    def sizeBits_humid(self):
        return 32
    
    #
    # Accessor methods for field: light
    #   Field type: float
    #   Offset (bits): 128
    #   Size (bits): 32
    #

    #
    # Return whether the field 'light' is signed (True).
    #
    def isSigned_light(self):
        return True
    
    #
    # Return whether the field 'light' is an array (False).
    #
    def isArray_light(self):
        return False
    
    #
    # Return the offset (in bytes) of the field 'light'
    #
    def offset_light(self):
        return (128 / 8)
    
    #
    # Return the offset (in bits) of the field 'light'
    #
    def offsetBits_light(self):
        return 128
    
    #
    # Return the value (as a float) of the field 'light'
    #
    def get_light(self):
        return self.getFloatElement(self.offsetBits_light(), 32, 0)
    
    #
    # Set the value of the field 'light'
    #
    def set_light(self, value):
        self.setFloatElement(self.offsetBits_light(), 32, value, 0)
    
    #
    # Return the size, in bytes, of the field 'light'
    #
    def size_light(self):
        return (32 / 8)
    
    #
    # Return the size, in bits, of the field 'light'
    #
    def sizeBits_light(self):
        return 32
    
