#include <platforms/hw.hpp>
#include <coro/coro_task.hpp>
#include <coro/async_flag.hpp>
#include <coro/coro_timer.hpp>

using namespace driver;
using namespace std::chrono_literals;

static uint8_t buf[1024];
static std::pmr::monotonic_buffer_resource pool(buf, sizeof(buf));

static async::coro_timer coro_timer_led3{ 1s };
static async::coro_timer coro_timer_led4{ 5s };

async::coro_task blink_led3() noexcept
{
    while (true)
    {
        coro_timer_led3.expires_after(1s);
        co_await coro_timer_led3.async_wait();
        platform::hw_instance::led3().toggle();
    }
}

async::coro_task blink_led4() noexcept
{
    while (true)
    {
        coro_timer_led4.expires_after(5s);
        co_await coro_timer_led4.async_wait();
        platform::hw_instance::led4().toggle();
    }
}

int main() {
    async::coro_task::set_resource(pool);

    auto res = platform::hw_init();

    async::launch_task(blink_led3).resume();
    async::launch_task(blink_led4).resume();

    while (true)
    {
        coro_timer_led3.process();
        coro_timer_led4.process();
    }

    return 0;
}
