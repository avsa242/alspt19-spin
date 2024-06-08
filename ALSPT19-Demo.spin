{
----------------------------------------------------------------------------------------------------
    Filename:       ALSPT19-Demo.spin
    Description:    Driver for the ALS-PT19 light sensor (analog)
    Author:         Jesse Burt
    Started:        Jun 8, 2024
    Updated:        Jun 8, 2024
    Copyright (c) 2024 - See end of file for terms of use.
----------------------------------------------------------------------------------------------------
}
CON

    _clkmode    = cfg._clkmode
    _xinfreq    = cfg._xinfreq


' Define the ADC driver object to use (default is MCP320x, if not specified)
#define ADC_DRIVER "signal.adc.mcp320x"
#pragma exportdef(ADC_DRIVER)


OBJ

    cfg:    "boardcfg.flip"
    time:   "time"
    ser:    "com.serial.terminal.ansi" | SER_BAUD=115_200
    sensor: "sensor.light.alspt19"
    adc:    ADC_DRIVER | CS=0, SCK=1, MOSI=2, MISO=3


PUB main() | al

    setup()


    adc.set_ref_voltage(4_870000)               ' ADC supply/reference voltage
    adc.set_adc_channel(0)

    sensor.attach_adc(@adc)                     ' tell the sensor driver the ADC object to talk to
    sensor.set_load_resistor(10_000)            ' ALSPT19: RL resistor value (ohms)
    sensor.set_adc_averaging(8)                 ' optional ADC averaging (0 to disable)

    repeat
        al := sensor.lux()
        ser.pos_xy(0, 3)
        ser.printf2(@"%d.%03.3dlx", (al / 1_000), ...
                                    (al // 1_000) )
        ser.clear_line()


PUB setup()

    ser.start()
    time.msleep(30)
    ser.clear()
    ser.strln(@"Serial terminal started")

    if ( adc.start() )
        ser.strln(@"ADC driver started")
    else
        ser.strln(@"ADC driver failed to start - halting")
        repeat

    { set up the ADC }
    adc.set_model(3002)


DAT
{
Copyright (c) 2024 Jesse Burt

Permission is hereby granted, free of charge, to any person obtaining a copy of this software and
associated documentation files (the "Software"), to deal in the Software without restriction,
including without limitation the rights to use, copy, modify, merge, publish, distribute,
sublicense, and/or sell copies of the Software, and to permit persons to whom the Software is
furnished to do so, subject to the following conditions:

The above copyright notice and this permission notice shall be included in all copies or
substantial portions of the Software.

THE SOFTWARE IS PROVIDED "AS IS", WITHOUT WARRANTY OF ANY KIND, EXPRESS OR IMPLIED, INCLUDING BUT
NOT LIMITED TO THE WARRANTIES OF MERCHANTABILITY, FITNESS FOR A PARTICULAR PURPOSE AND
NONINFRINGEMENT. IN NO EVENT SHALL THE AUTHORS OR COPYRIGHT HOLDERS BE LIABLE FOR ANY CLAIM,
DAMAGES OR OTHER LIABILITY, WHETHER IN AN ACTION OF CONTRACT, TORT OR OTHERWISE, ARISING FROM, OUT
OF OR IN CONNECTION WITH THE SOFTWARE OR THE USE OR OTHER DEALINGS IN THE SOFTWARE.
}

