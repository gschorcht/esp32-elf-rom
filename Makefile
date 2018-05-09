##############################################
#
# Convert ROM image to ELF file with exports
#
# (C) 2015 Max Filippov <jcmvbkbc@gmail.com>
# (C) 2018 Gunar Schorcht <gunar@schorcht.net>
#
# License: MIT
#
##############################################

AS = xtensa-esp32-elf-as
LD = xtensa-esp32-elf-ld

all: bootrom.elf
clean:
	rm -f bootrom.elf rom-functions.s bootrom.o

#
# Consolidate multiple esp32.rom.ld files
#
esp32.rom.ld:
	find -name esp32.rom.ld | xargs sort -t ' ' -k 5 -u > $@

%.elf: %.o
	$(LD) -M -T bootrom.ld -r $^ -o $@

rom-functions.s: esp32.rom.ld
	sed -n 's/PROVIDE[[:space:]]*([[:space:]]*\([^[:space:]=]\+\)[^0]\+\(0x4.......\).*/\1 = \2 - 0x40000000 + _rstext\n.global \1\n.type \1, @function/p' < $^ > $@

%.o: %.s rom-functions.s
	$(AS) $< -o $@
