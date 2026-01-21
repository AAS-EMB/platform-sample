cmake_minimum_required(VERSION 3.20)
project(platform-sample LANGUAGES C CXX ASM)

set(CMAKE_CXX_STANDARD 20)

if(NOT PLATFORM)
    message(FATAL_ERROR "Use -DPLATFORM=stm32f1")
endif()

include(cmake/cross-file/${PLATFORM}.cmake)
include(cmake/external/stm32f1_cmsis.cmake)
include(cmake/external/stm32f1_hal.cmake)

add_compile_options(${PLATFORM_COMPILE_OPTIONS})
add_link_options(${PLATFORM_LINK_OPTIONS})
#add_compile_definitions(PLATFORM_STM32F1)

set(CHRONO_CLOCKS_LIB ON CACHE BOOL "" FORCE)
set(GPIO_LIB ON CACHE BOOL "" FORCE)
set(PLATFORM ${PLATFORM} CACHE STRING "Target platform" FORCE)
add_subdirectory(external/platform-drivers)

add_executable(app
    src/main.cpp
    src/platform/stm32f1/hw.cpp
    src/platform/stm32f1/hw_init.cpp
    src/platform/stm32f1/system/startup.s
)

target_link_libraries(app
    PRIVATE
        stm32f1_cmsis
        stm32f1_hal
        chrono_clocks
        gpio_driver
)