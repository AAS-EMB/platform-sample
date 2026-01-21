# 🚀 STM32 Platform Sample Project

Sample application showcasing a **clean, scalable embedded architecture** for STM32 using  
**CMake**, **HAL/CMSIS**, and a custom reusable **platform-drivers framework**.

This project is intended as:
- a reference for modern STM32 project layout,
- a validation project for `platform-drivers`,
- and a base template for real embedded applications.

---

## 📌 Key Features

- ⚙️ Cross-platform build system (Host + STM32)
- 🧱 Clean separation: Application ↔ Drivers ↔ Platform ↔ Vendor
- 🧩 Modular driver framework (`platform-drivers`)
- 🕒 Custom chrono implementation for embedded
- 🔧 STM32 HAL + CMSIS integration
- 🧪 Ready for CI & host-side unit testing
- 🗂 Modern CMake with target-based design
- 🚫 No global flags / no global includes
- 📦 Vendor code isolated (no modification of external deps)

---

## 🧭 Architecture Overview

platform-sample/
├── src/
│ └── platform/
│ └── stm32f1/
│ ├── hw.hpp / hw.cpp # Hardware abstraction layer
│ ├── hw_init.hpp / hw_init.cpp # HAL/CMSIS init (RCC, GPIO, etc)
│ └── system/
│ ├── startup.s
│ ├── linker.ld
│ ├── stm32f1xx_hal_conf.h
│ └── system_stm32f1xx.c
│
├── cmake/
│ ├── toolchain/arm-none-eabi.cmake
│ └── cross-file/stm32f1.cmake
│
├── external/
│ ├── cmsis-core/
│ ├── cmsis-device-f1/
│ ├── stm32f1-hal/
│ └── platform-drivers/
│
└── CMakeLists.txt

---

## 🧱 Layered Design

+-------------------+
| Application | <- platform-sample (this repo)
+-------------------+
| Platform Drivers | <- chrono, gpio, uart, etc
+-------------------+
| Platform Config | <- STM32F1 / STM32F3 / STM32F7
+-------------------+
| CMSIS + HAL | <- Vendor code
+-------------------+
| Hardware |
+-------------------+

---

## 🧩 platform-drivers

This project depends on a reusable driver framework:

- `chrono_clocks` – embedded-friendly std::chrono-like clocks
- `gpio` – platform-agnostic GPIO abstraction
- future: UART, CAN, SPI, I2C, ETH, USB

Drivers are:
- header-only or static
- platform-aware via traits & compile-time selection
- usable on host for unit tests

---

## ⚙️ Supported Platforms

| Platform | Status |
|----------|---------|
Host (Linux/macOS) | ✅ |
STM32F1 | ✅ |
STM32F3 | ⏳ Planned |
STM32F7 | ⏳ Planned |

---

## 🛠 Build Instructions

### 📦 Prerequisites

- `cmake >= 3.20`
- `arm-none-eabi-gcc`
- `make` or `ninja`
- git submodules initialized

---

## 🧪 Host build (for tests / CI)

cmake -S . -B build-host -DPLATFORM=host
cmake --build build-host

--

## 🔩 STM32F1 build

cmake -S . -B build-stm32f1 \
  -DCMAKE_TOOLCHAIN_FILE=cmake/toolchain/arm-none-eabi.cmake \
  -DPLATFORM=stm32f1

cmake --build build-stm32f1