file(GLOB STM32F1_HAL_SOURCES
    ${CMAKE_SOURCE_DIR}/external/platform-drivers/external/stm32f1_hal/Src/stm32f1xx_hal_gpio_ex.c
    ${CMAKE_SOURCE_DIR}/external/platform-drivers/external/stm32f1_hal/Src/stm32f1xx_hal_tim.c
    ${CMAKE_SOURCE_DIR}/external/platform-drivers/external/stm32f1_hal/Src/stm32f1xx_hal_tim_ex.c
    ${CMAKE_SOURCE_DIR}/external/platform-drivers/external/stm32f1_hal/Src/stm32f1xx_hal.c
    ${CMAKE_SOURCE_DIR}/external/platform-drivers/external/stm32f1_hal/Src/stm32f1xx_hal_rcc.c
    ${CMAKE_SOURCE_DIR}/external/platform-drivers/external/stm32f1_hal/Src/stm32f1xx_hal_rcc_ex.c
    ${CMAKE_SOURCE_DIR}/external/platform-drivers/external/stm32f1_hal/Src/stm32f1xx_hal_gpio.c
    ${CMAKE_SOURCE_DIR}/external/platform-drivers/external/stm32f1_hal/Src/stm32f1xx_hal_dma.c
    ${CMAKE_SOURCE_DIR}/external/platform-drivers/external/stm32f1_hal/Src/stm32f1xx_hal_cortex.c
    ${CMAKE_SOURCE_DIR}/external/platform-drivers/external/stm32f1_hal/Src/stm32f1xx_hal_pwr.c
    ${CMAKE_SOURCE_DIR}/external/platform-drivers/external/stm32f1_hal/Src/stm32f1xx_hal_flash.c
    ${CMAKE_SOURCE_DIR}/external/platform-drivers/external/stm32f1_hal/Src/stm32f1xx_hal_flash_ex.c
    ${CMAKE_SOURCE_DIR}/external/platform-drivers/external/stm32f1_hal/Src/stm32f1xx_hal_exti.c
    ${CMAKE_SOURCE_DIR}/src/platforms/stm32f1/system/system_stm32f1xx.c
    ${CMAKE_SOURCE_DIR}/src/platforms/stm32f1/system/stm32f1xx_hal_msp.c
)

add_library(stm32f1_hal STATIC
    ${STM32F1_HAL_SOURCES}
)

target_include_directories(stm32f1_hal PUBLIC
    ${CMAKE_SOURCE_DIR}/external/platform-drivers/external/stm32f1_hal/Inc
    ${CMAKE_SOURCE_DIR}/src/platforms/stm32f1/system
)

target_link_libraries(stm32f1_hal PUBLIC
    stm32f1_cmsis
    platform_flags
)
