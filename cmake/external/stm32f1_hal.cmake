file(GLOB STM32F1_HAL_SOURCES
    ${CMAKE_SOURCE_DIR}/external/stm32f1-hal/Src/stm32f1xx_hal.c
    ${CMAKE_SOURCE_DIR}/external/stm32f1-hal/Src/stm32f1xx_hal_gpio.c
    ${CMAKE_SOURCE_DIR}/external/stm32f1-hal/Src/stm32f1xx_hal_rcc.c
    ${CMAKE_SOURCE_DIR}/external/stm32f1-hal/Src/stm32f1xx_hal_uart.c
    ${CMAKE_SOURCE_DIR}/external/stm32f1-hal/Src/stm32f1xx_hal_dma.c
    ${CMAKE_SOURCE_DIR}/external/stm32f1-hal/Src/stm32f1xx_hal_flash.c
    ${CMAKE_SOURCE_DIR}/src/platform/stm32f1/system/*.c
)

add_library(stm32f1_hal STATIC
    ${STM32F1_HAL_SOURCES}
)

target_include_directories(stm32f1_hal PUBLIC
    ${CMAKE_SOURCE_DIR}/external/stm32f1-hal/Inc
    ${CMAKE_SOURCE_DIR}/src/platform/stm32f1/system
)

target_link_libraries(stm32f1_hal PUBLIC stm32f1_cmsis)
