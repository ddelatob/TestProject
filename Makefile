TARGET = main

LD_SCRIPT = STM32L432KC.ld
MCU_SPEC = cortex-m4

CC = bin/arm-none-eabi-gcc
AS = bin/arm-none-eabi-as
LD = bin/arm-none-eabi-ld
OC = bin/arm-none-eabi-objcopy
OD = bin/arm-none-eabi-objdump
OS = bin/arm-none-eabi-size

ASFLAGS += -c
asflags += -O0
ASFLAGS += -mcpu=$(MCU_SPEC)
ASFLAGS += -mthumb
ASFLAGS += -Wall
ASFLAGS += -fmessage-length=0

CFLAGS += -mcpu=$(MCU_SPEC)
CFLAGS += -mthumb
CFLAGS += -Wall
CFLAGS += -g
CFLAGS += -fmessage-length=0
CFLAGS += --specs=nosys.specs

LSCRIPT = ./$(LD_SCRIPT)
LFLAGS += -mcpu=$(MCU_SPEC)
LFLAGS += -mthumb
LFLAGS += -Wall
LFLAGS += --specs=nosys.specs
LFLAGS += -nostdlib
LFLAGS += -lgcc
LFLAGS += -T$(LSCRIPT)

AS_SRC = ./core.S
C_SRC = ./main.c

OBJS = $(AS_SRC:.S=.o)
OBJS += $(C_SRC:.c=.o)

.PHONY: all
all: $(TARGET).bin

%.o: %.S
	$(CC) -x assembler-with-cpp $(ASFLAGS) $< -o $@

%.o: %.c
  $(CC) -c $(CFLAGS) $(INCLUDE) $< -o $@

$(TARGET).elf: $(OBJS)
  $(CC) $^ $(LFLAGS) -o $@

$(TARGET).bin: $(TARGET).elf
  $(OC) -S -O binary $< $@
  $(OS) $<

.PHONY: clean
clean:
  rm -f $(OBJS)
  rm -f $(TARGET).elf