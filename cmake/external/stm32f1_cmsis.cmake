add_library(stm32f1_cmsis INTERFACE)

target_include_directories(stm32f1_cmsis INTERFACE
    ${CMAKE_SOURCE_DIR}/external/platform-drivers/external/cmsis/Core/Include
    ${CMAKE_SOURCE_DIR}/external/platform-drivers/external/cmsis-device-f1/Include
)

target_compile_definitions(stm32f1_cmsis INTERFACE
    STM32F100xB
    STM32F1
)
