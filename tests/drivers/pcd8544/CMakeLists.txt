# SPDX-License-Identifier: Apache-2.0

cmake_minimum_required(VERSION 3.20.0)

set(FW_PATH $ENV{FW_PATH})
# DTC_OVERLAY_FILE changes must be made before calling find_package(Zephyr ..).

list(APPEND DTC_OVERLAY_FILE ${FW_PATH}/boards/${BOARD}.overlay)
find_package(Zephyr REQUIRED HINTS $ENV{ZEPHYR_BASE})
project(pcd8544_test)

FILE(GLOB app_sources src/*.c)
target_include_directories(app PRIVATE ${FW_PATH}/drivers/pcd8544)

target_sources(app PRIVATE ${app_sources} ${FW_PATH}/drivers/pcd8544/pcd8544.c)

