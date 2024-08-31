# sources.mk

# Common sources
COMMON_SOURCES = src/main.c \
                 src/memory.c \
                 src/system_msp432p401r.c

# Platform specific sources
MSP432_SOURCES = src/interrupts_msp432p401r_gcc.c \
                 src/startup_msp432p401r_gcc.c

HOST_SOURCES = # Add any host-specific sources if needed

# Combine the sources based on the platform
ifeq ($(PLATFORM),MSP432)
    SOURCES = $(COMMON_SOURCES) $(MSP432_SOURCES)
    INCLUDES = -Iinclude/common -Iinclude/msp432 -Iinclude/CMSIS
else
    SOURCES = $(COMMON_SOURCES) $(HOST_SOURCES)
    INCLUDES = -Iinclude/common
endif
