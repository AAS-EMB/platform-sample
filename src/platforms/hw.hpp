#pragma once

#if defined(PLATFORM_STM32F1)
#include "stm32f1/hw.hpp"
#else
#error "Unsupported platform"
#endif

namespace platform {

[[nodiscard]] bool hw_init() noexcept;

struct hw_instance : hw_instance_ { };

}