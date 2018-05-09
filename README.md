# esp32-elf-rom

## Overview

This tiny project allows converting ESP32 ROM blob to ELF file with symbols. It is derived from [esp-elf-rom](https://github.com/jcmvbkbc/esp-elf-rom.git) project.

## Usage

First, you need a ROM image. Either you can use file ```bootrom.bin``` in this repository or you use ```esptool.py``` to download a ROM image with command:

```
esptool.py --chip esp32 -b 921600 -p /dev/ttyUSB0 dump_mem 0x40000000 0x00064ae0 bootrom.bin

```

Once, you have the ROM image, use simply command

```
make
```

to produce an ELF file ```bootrom.elf``` that can be used with command

```
xtensa-esp32-elf-objdump -d bootrom.elf > bootrom_disassembled.s
```

to disassemble the ROM code.
