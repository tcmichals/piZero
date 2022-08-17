import time
import spidev

BLUE_LED_OFFSET= 4
RED_LED_OFFSET= 5
GREEN_LED_OFFSET= 6

spi_ch = 0

# Enable SPI
spi = spidev.SpiDev(0, spi_ch)
spi.max_speed_hz = 1200000

def addLed( offset, value):
    return (value & ( 1 << offset )) << offset
	

def writeLED(led_0_3, led_r=0, led_b=0, led_g=0 ):

    led_val = led_0_3
    # led_val = addLed(BLUE_LED_OFFSET, led_b)
    # led_val = addLed(RED_LED_OFFSET, led_r)
    # led_val = addLed(RED_LED_OFFSET, led_r)
    
    msg = [0xA2, 1, 2,3,4,0,4, led_val, 0,0,0,0 ]
    reply = spi.xfer2(msg)


# Report the channel 0 and channel 1 voltages to the terminal
try:
    max_count = range( 2 ** 4 -1)
    for n in max_count:
        writeLED(n);
        time.sleep(0.2)

finally:
    spi.close()



