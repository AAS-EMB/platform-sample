cmake_minimum_required(VERSION 3.20)
project(platform-sample LANGUAGES C CXX ASM)

enable_language(C ASM CXX)
set(CMAKE_CXX_STANDARD 20)

if(NOT PLATFORM)
    message(FATAL_ERROR "Use -DPLATFORM=stm32f1")
endif()

if(NOT CMAKE_BUILD_TYPE)
    set(CMAKE_BUILD_TYPE "Release")
endif()

include(cmake/cross-file/${PLATFORM}.cmake)
add_compile_options(${PLATFORM_COMPILE_OPTIONS})
add_link_options(${PLATFORM_LINK_OPTIONS})

include(cmake/external/stm32f1_cmsis.cmake)
include(cmake/external/stm32f1_hal.cmake)

set(CHRONO_CLOCKS_LIB ON CACHE BOOL "" FORCE)
set(GPIO_LIB ON CACHE BOOL "" FORCE)
set(CORO_LIB ON CACHE BOOL "" FORCE)

set(PLATFORM ${PLATFORM} CACHE STRING "Target platform" FORCE)
add_subdirectory(external/platform-drivers)

add_executable(sample
    ${CMAKE_SOURCE_DIR}/src/main.cpp
    ${CMAKE_SOURCE_DIR}/src/platforms/stm32f1/hw.cpp
    ${CMAKE_SOURCE_DIR}/src/platforms/stm32f1/hw_init.cpp
    ${CMAKE_SOURCE_DIR}/src/platforms/stm32f1/system/startup.s
    ${CMAKE_SOURCE_DIR}/src/platforms/stm32f1/system/stm32f1xx_it.c
    ${CMAKE_SOURCE_DIR}/src/platforms/stm32f1/system/syscalls.c
    ${CMAKE_SOURCE_DIR}/src/platforms/stm32f1/system/sysmem.c
)

target_include_directories(sample PRIVATE
    ${CMAKE_SOURCE_DIR}/src
)

target_link_libraries(sample
    PRIVATE
        stm32f1_cmsis
        stm32f1_hal
        chrono_clocks
        gpio_driver
        coro_lib
)

add_custom_command(TARGET sample POST_BUILD
    COMMAND ${CMAKE_OBJCOPY} -O binary
            $<TARGET_FILE:sample>
            $<TARGET_FILE_DIR:sample>/sample.bin
    COMMAND ${CMAKE_OBJCOPY} -O ihex
            $<TARGET_FILE:sample>
            $<TARGET_FILE_DIR:sample>/sample.hex
    COMMENT "Generating binary and hex images"
)