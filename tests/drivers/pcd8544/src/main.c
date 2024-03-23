/*
 * Copyright (c) 2016 Intel Corporation
 *
 * SPDX-License-Identifier: Apache-2.0
 */

#include <zephyr/kernel.h>
#include <zephyr/ztest.h>

#include "pcd8544.h"

ZTEST_SUITE(pcd8544, NULL, NULL, NULL, NULL, NULL);

ZTEST(pcd8544, test_backlight_on) {
  zassert_equal(0, pcd8544_init());
  zassert_equal(0, pcd8544_backlight_on());
  k_msleep(1000);
  zassert_equal(0, pcd8544_deinit());
}
