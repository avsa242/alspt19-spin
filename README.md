# alspt19-spin
--------------

This is a P8X32A/Propeller, P2X8C4M64P/Propeller 2 driver object for the ALSPT19 ambient light sensor

**IMPORTANT**: This software is meant to be used with the [spin-standard-library](https://github.com/avsa242/spin-standard-library) (P8X32A) or [p2-spin-standard-library](https://github.com/avsa242/p2-spin-standard-library) (P2X8C4M64P). Please install the applicable library first before attempting to use this code, otherwise you will be missing several files required to build the project.


## Salient Features

* Connection to any compatible ADC driver object (demo code uses MCP320x)
* Read ADC voltage with optional averaging
* Calculate photocurrent based on set load resistor
* Calculate illuminance in lux (unverified)


## Requirements

P1/SPIN1:
* spin-standard-library

P2/SPIN2:
* p2-spin-standard-library


## Compiler Compatibility

| Processor | Language | Compiler               | Backend      | Status                |
|-----------|----------|------------------------|--------------|-----------------------|
| P1        | SPIN1    | FlexSpin (6.9.4)       | Bytecode     | OK                    |
| P1        | SPIN1    | FlexSpin (6.9.4)       | Native/PASM  | OK                    |
| P2        | SPIN2    | FlexSpin (6.9.4)       | NuCode       | Not yet implemented   |
| P2        | SPIN2    | FlexSpin (6.9.4)       | Native/PASM2 | Not yet implemented   |

(other versions or toolchains not listed are __not supported__, and _may or may not_ work)


## Hardware compatibility

* Tested with Adafruit [#2748](https://www.adafruit.com/product/2748) with 10K load resistor using an MCP3002 ADC


## Limitations

* Very early in development - may malfunction, or outright fail to build
* Lux calculations aren't verified by calibrated equipment. The load resistor fitted to the circuit may be adequate to provide reasonably accurate measurements in some lighting situations and ranges, but not others.

