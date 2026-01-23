#include <platforms/hw.hpp>

int main() {
    using namespace std::chrono_literals;

    auto res = platform::hw_init();

    auto last = driver::steady_clock::now();

    while (true) {
        if (driver::steady_clock::now() - last >= 1s) {
          platform::hw_instance::led3().toggle();
          platform::hw_instance::led4().toggle();
          last = driver::steady_clock::now();
        }
    }

    return 0;
}
