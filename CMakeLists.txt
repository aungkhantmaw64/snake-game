cmake_minimum_required(VERSION 3.20.0)

set(FW_PATH $ENV{FW_PATH})
# DTC_OVERLAY_FILE changes must be made before calling find_package(Zephyr ..).

list(APPEND DTC_OVERLAY_FILE ${FW_PATH}/boards/${BOARD}.overlay)
find_package(Zephyr REQUIRED HINTS $ENV{ZEPHYR_BASE})
project(snake-game)

target_sources(app PRIVATE src/main.c)

add_subdirectory(drivers)