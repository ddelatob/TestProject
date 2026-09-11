ENTRY(reset_handler)

_estack = 0x20010000;

_Min_Leftover_RAM = 0x400;

MEMORY
{
    FLASH ( rx )    : ORIGIN = 0x08000000, LENGTH = 256K
    RAM ( rxw )     : ORIGIN = 0x20000000, LENGTH = 64K
}

SECTIONS
{
    .vector_table :
    {
        . = ALIGN(4);
        KEEP (*(.vector_table))
        . = ALIGN(4);
    } >FLASH

    .text:
    {
        . = ALIGN(4);
        *(.text)
        *(.text*)
        . = ALIGN(4);
    } >FLASH

    .rodata:
    {
        . = ALIGN(4);
        *(.rodata)
        *(.rodata*)
        . = ALIGN(4);
    } >FLASH
}