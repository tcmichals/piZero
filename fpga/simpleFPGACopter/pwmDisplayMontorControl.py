
import curses
from curses import wrapper
import spidev

spi_ch = 1



spi = spidev.SpiDev(0, spi_ch)
spi.max_speed_hz = 5000000



def getPWMValues(offset):
    msg = [0xA1, 0,0,0x1,offset * 4,0,4,0,0,0,0,0,0,0,0]
    reply = spi.xfer2(msg)
    for i in reply:
        print("0x%02X " % i, end='')
    print("")




def main(stdscr):
    # Clear screen
    stdscr.clear()

    curses.noecho()

    curses.cbreak()

    begin_x = 0; begin_y = 0
    height = 20; width = 80
    win = curses.newwin(height, width, begin_y, begin_x)

    win.refresh()
    # This raises ZeroDivisionError when i == 10.

    stdscr.addstr(0, 0, "Current mode: Typing mode 0", curses.A_REVERSE)
    stdscr.addstr(1, 0, "Current mode: Typing mode 1", curses.A_REVERSE)

    #    stdscr.addstr(i, 0, '10 divided by {} is {}'.format(v, 10/v))

    stdscr.refresh()
    stdscr.getkey()

getPWMValues(0)
getPWMValues(1)
getPWMValues(2)
getPWMValues(3)
getPWMValues(4)
getPWMValues(5)
getPWMValues(6)
#wrapper(main)


