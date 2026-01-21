message(STATUS "Using STM32F1 platform")

set(MCU cortex-m3)

set(PLATFORM_COMPILE_OPTIONS
    -mcpu=${MCU}
    -mthumb
    -ffunction-sections
    -fdata-sections
)

set(PLATFORM_LINK_OPTIONS
    -mcpu=${MCU}
    -mthumb
    -Wl,--gc-sections
    -Wl,--print-memory-usage
    -specs=nano.specs
    -specs=nosys.specs
)

set(LINKER_SCRIPT
    ${CMAKE_SOURCE_DIR}/src/platform/stm32f1/system/linker.ld
)

list(APPEND PLATFORM_LINK_OPTIONS
    -T${LINKER_SCRIPT}
)
