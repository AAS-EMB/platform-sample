

#include "hw.hpp"
#include "hw_init.hpp"

using namespace driver;

extern "C" {

void SysTick_Handler()
{
    HAL_IncTick();
    chrono_traits::systick_irq();
}

}

namespace platform {

IGpio & hw_instance_::led3() noexcept {
    static gpio instance{ LD3_GPIO_Port, LD3_Pin };
    return instance;
}

IGpio & hw_instance_::led4() noexcept {
    static gpio instance{ LD4_GPIO_Port, LD4_Pin };
    return instance;
}

[[nodiscard]] bool hw_init() noexcept {
    HAL_Init();

    SystemClock_Config();

    GPIO_Init();

    chrono_traits::init();
    hw_instance_::led3().reset();
    hw_instance_::led4().reset();

    return true;
}

}