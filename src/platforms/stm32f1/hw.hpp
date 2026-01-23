#pragma once
#include <chrono_clocks/steady_clock.hpp>
#include <chrono_clocks/system_clock.hpp>
#include <platform/stm32/gpio.hpp>

namespace platform {

struct hw_instance_ {
    static driver::IGpio & led3() noexcept;
    static driver::IGpio & led4() noexcept;
};

}