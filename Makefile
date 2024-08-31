# Makefile

include sources.mk

# Define variables
TARGET = c1m2.out
MAP_FILE = c1m2.map

ifeq ($(PLATFORM),MSP432)
    CC = arm-none-eabi-gcc
    CFLAGS = -Wall -Werror -g -O0 -std=c99 $(INCLUDES) -DMSP432
    LDFLAGS = -T msp432p401r.lds
    ARCH_FLAGS = -mcpu=cortex-m4 -mthumb -march=armv7e-m -mfloat-abi=hard -mfpu=fpv4-sp-d16 --specs=nosys.specs
else
    CC = gcc
    CFLAGS = -Wall -Werror -g -O0 -std=c99 $(INCLUDES) -DHOST
    LDFLAGS =
    ARCH_FLAGS =
endif

# Compiler and linker flags
CPPFLAGS = 
CFLAGS += $(CPPFLAGS) $(ARCH_FLAGS)
LDFLAGS += $(ARCH_FLAGS) -Wl,-Map=$(MAP_FILE)

# Object files
OBJECTS = $(SOURCES:.c=.o)

# Default target
.PHONY: all
all: build

# Build target
.PHONY: build
build: $(TARGET)

# Link the executable
$(TARGET): $(OBJECTS)
	$(CC) $(CFLAGS) $(OBJECTS) -o $@ $(LDFLAGS)

# Compile all object files but do not link
.PHONY: compile-all
compile-all: $(OBJECTS)

%.o: %.c
	$(CC) $(CFLAGS) -c $< -o $@

# Generate the preprocessed output of all c-program implementation files
%.i: %.c
	$(CC) $(CFLAGS) -E $< -o $@

# Generate assembly output of c-program implementation files
%.asm: %.c
	$(CC) $(CFLAGS) -S $< -o $@

# Clean target
.PHONY: clean
clean:
	rm -f $(OBJECTS) $(TARGET) $(MAP_FILE) *.i *.asm *.d
