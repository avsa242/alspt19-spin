{
----------------------------------------------------------------------------------------------------
    Filename:       sensor.light.alspt19.spin
    Description:    Driver for the ALS-PT19 light sensor (analog)
    Author:         Jesse Burt
    Started:        Jun 8, 2024
    Updated:        Jun 8, 2024
    Copyright (c) 2024 - See end of file for terms of use.
----------------------------------------------------------------------------------------------------

    NOTE: This object requires an external ADC driver with a function called 'voltage()'
        that returns ADC measurements in microvolts.
    Start the ADC driver in your application, then attach this object to it using attach().
    See the included demo for an example.

}


CON

{ if no ADC driver has been defined, default to the MCP320x driver }
#ifndef ADC_DRIVER
#   define ADC_DRIVER "signal.adc.mcp320x.spin"
#endif


    LUX_SCALE   = 4_500                         ' scaling factor used in lux calculation
                                                '   (1_000 = 1.000)

OBJ

    adc=    ADC_DRIVER                          ' "virtual" ADC driver instance
    math:   "math.unsigned64"                   ' unsigned 64-bit math ops


VAR

    long _p_adc                                 ' pointer to ADC object

    long _load_res                              ' RL: loading resistor value

    byte _averaging                             ' # ADC samples to average


PUB null()
' This is not a top-level object


PUB bind = attach_adc
PUB attach_adc(p_adc)
' Attach an ADC driver
'   p_adc: pointer to an ADC driver object
    _p_adc := p_adc


PUB lux(): l
' Get illuminance measurement from sensor
'   Returns: illuminance in milli-lux (1_000 = 1.000lx)
    return ( math.multdiv(  photocurrent(), ...
                            LUX_SCALE, ...
                            1_000) )            ' ( photocurrent() * LUX_SCALE ) / 1_000


PUB photocurrent(): i
' Get current flow through sensor
'   Returns: current in microamperes
    return ( math.multdiv(  voltage(), ...
                            1_000, ...
                            _load_res) )


PUB set_adc_averaging(a=0)
' Set number of ADC samples to average before returning a measurement
'   a: number of samples (default: 0)
    _averaging := a


PUB set_load_resistor(r)
' Set the value of the loading resistor used
'   r: resistance in ohms
    _load_res := r


PUB voltage(): v | a
' ADC voltage measurement
'   Returns: measurement in microvolts (1_000_000 = 1.000000V)
    a := _averaging
    if ( a )
        v := 0
        repeat a
            v += adc[_p_adc].voltage()
        return (v / a)
    else
        return adc[_p_adc].voltage()


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

