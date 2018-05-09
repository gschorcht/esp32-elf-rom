MEMORY
{
    /* Last function in current rom ends at 0x40064add. That is for the moment
       it is enough to read out from rom and convert only 0x00064ae0 byte */
    bootrom0 : org = 0x40000000, len = 0x00064ae0
}

SECTIONS
{
	.text : ALIGN(4)
	{
		*(.text)
	} > bootrom0

	/DISCARD/ : { *(.data .bss) }
} 
