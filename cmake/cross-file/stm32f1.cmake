message(STATUS "Using STM32F1 platform")

set(MCU cortex-m3)

set(PLATFORM_COMMON_FLAGS
    -mcpu=${MCU}
    -mthumb
    -O3
    -g0
)

set(PLATFORM_C_FLAGS
    -Wall
    -Wextra
    -Wpedantic
    -ffunction-sections
    -fdata-sections
)

set(PLATFORM_CXX_FLAGS
    ${PLATFORM_C_FLAGS}
    -fno-exceptions
    -fno-rtti
    -fno-threadsafe-statics
    -fcoroutines
)

set(PLATFORM_LINK_COMMON
    -mcpu=${MCU}
    -mthumb
    -Wl,--gc-sections
    -Wl,--print-memory-usage
    -specs=nano.specs
    -specs=nosys.specs
)

set(PLATFORM_LINK_LIBS
    -lc
    -lm
    -lstdc++
    -lsupc++
)

set(LINKER_SCRIPT
    ${CMAKE_SOURCE_DIR}/src/platforms/stm32f1/system/linker.ld
)

set(PLATFORM_LINK_SCRIPT
    -T${LINKER_SCRIPT}
)

