cmake_minimum_required(VERSION 3.20)

project(platform-sample
    VERSION 1.0.0
    LANGUAGES C CXX ASM
)

# =========================================================
# Versioning
# =========================================================

if(DEFINED ENV{BUILD_NUMBER})
    set(PROJECT_BUILD $ENV{BUILD_NUMBER})
else()
    set(PROJECT_BUILD 0)
endif()

set(PROJECT_VERSION_FULL
    "${PROJECT_VERSION}-${PROJECT_BUILD}"
)

message(STATUS "Project version: ${PROJECT_VERSION_FULL}")

configure_file(
    ${CMAKE_SOURCE_DIR}/cmake/version/version.hpp.in
    ${CMAKE_BINARY_DIR}/generated/version.hpp
    @ONLY
)

# =========================================================
# Global settings
# =========================================================

set(CMAKE_CXX_STANDARD 20)
set(CMAKE_CXX_STANDARD_REQUIRED ON)

if(NOT PLATFORM)
    message(FATAL_ERROR "Use -DPLATFORM=stm32f1")
endif()

if(NOT CMAKE_BUILD_TYPE)
    set(CMAKE_BUILD_TYPE Release CACHE STRING "Build type" FORCE)
endif()

# =========================================================
# Toolchain / platform
# =========================================================

include(cmake/cross-file/${PLATFORM}.cmake)

add_compile_options(${PLATFORM_COMPILE_OPTIONS})
add_link_options(${PLATFORM_LINK_OPTIONS})

# =========================================================
# External dependencies
# =========================================================

include(cmake/external/stm32f1_cmsis.cmake)
include(cmake/external/stm32f1_hal.cmake)

set(CHRONO_CLOCKS_LIB ON CACHE BOOL "" FORCE)
set(GPIO_LIB ON CACHE BOOL "" FORCE)
set(CORO_LIB ON CACHE BOOL "" FORCE)

set(PLATFORM ${PLATFORM} CACHE STRING "Target platform" FORCE)
add_subdirectory(external/platform-drivers)

# =========================================================
# Target
# =========================================================

add_executable(sample
    ${CMAKE_SOURCE_DIR}/src/main.cpp
    ${CMAKE_SOURCE_DIR}/src/platforms/stm32f1/hw.cpp
    ${CMAKE_SOURCE_DIR}/src/platforms/stm32f1/hw_init.cpp
    ${CMAKE_SOURCE_DIR}/src/platforms/stm32f1/system/startup.s
    ${CMAKE_SOURCE_DIR}/src/platforms/stm32f1/system/stm32f1xx_it.c
    ${CMAKE_SOURCE_DIR}/src/platforms/stm32f1/system/syscalls.c
    ${CMAKE_SOURCE_DIR}/src/platforms/stm32f1/system/sysmem.c
)

set_target_properties(sample PROPERTIES
    OUTPUT_NAME "sample-${PROJECT_VERSION_FULL}"
    SUFFIX ".elf"
)

target_link_options(sample PRIVATE
    -Wl,-Map=$<TARGET_FILE_DIR:sample>/sample-${PROJECT_VERSION_FULL}.map
)

target_include_directories(sample PRIVATE
    ${CMAKE_SOURCE_DIR}/src
     ${CMAKE_BINARY_DIR}/generated
)

target_link_libraries(sample
    PRIVATE
        stm32f1_cmsis
        stm32f1_hal
        chrono_clocks
        gpio_driver
        coro_lib
)

# =========================================================
# Post-build artifacts
# =========================================================

add_custom_command(TARGET sample POST_BUILD
    COMMAND ${CMAKE_OBJCOPY} -O binary
            $<TARGET_FILE:sample>
            $<TARGET_FILE_DIR:sample>/sample-${PROJECT_VERSION_FULL}.bin
    COMMAND ${CMAKE_OBJCOPY} -O ihex
            $<TARGET_FILE:sample>
            $<TARGET_FILE_DIR:sample>/sample-${PROJECT_VERSION_FULL}.hex
    COMMENT "Generating binary and hex images (${PROJECT_VERSION_FULL})"
)