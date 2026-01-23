message(STATUS "Using STM32F1 platform")

set(MCU cortex-m3)

set(PLATFORM_COMPILE_OPTIONS
    -mcpu=${MCU}
    -mthumb
    -Wall
    -Wextra
    -Wpedantic
    -ffunction-sections
    -fdata-sections
    -fno-exceptions
    -fno-rtti
    -fno-threadsafe-statics
    -O0
    -g3
)

set(PLATFORM_LINK_OPTIONS
    -mcpu=${MCU}
    -mthumb
    -Wl,-Map=${CMAKE_PROJECT_NAME}.map
    -Wl,--gc-sections
    -Wl,--start-group
    -lc
    -lm
    -lstdc++
    -lsupc++
    -Wl,--end-group
    -Wl,--print-memory-usage
    -specs=nano.specs
    -specs=nosys.specs
)

set(LINKER_SCRIPT
    ${CMAKE_SOURCE_DIR}/src/platforms/stm32f1/system/linker.ld
)

list(APPEND PLATFORM_LINK_OPTIONS
    -T${LINKER_SCRIPT}
)

