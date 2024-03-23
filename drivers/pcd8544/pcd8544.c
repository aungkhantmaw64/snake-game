#include "pcd8544.h"

#include <zephyr/drivers/gpio.h>

#define PCD8544_BACKLIGHT_NODE DT_NODELABEL(pcd8544_backlight)

enum {
  BACKLIGHT = 0,
};

static const struct gpio_dt_spec pcd8544_gpios[1] = {
    [BACKLIGHT] = GPIO_DT_SPEC_GET(PCD8544_BACKLIGHT_NODE, gpios)};

int pcd8544_init() {
  int ret = 0;
  if (!gpio_is_ready_dt(&pcd8544_gpios[BACKLIGHT])) {
    return -EBUSY;
  }
  ret = gpio_pin_configure_dt(&pcd8544_gpios[BACKLIGHT], GPIO_OUTPUT_ACTIVE);
  if (ret < 0) {
    return ret;
  }
  ret = gpio_pin_set_dt(&pcd8544_gpios[BACKLIGHT], 0);
  if (ret < 0) {
    return ret;
  }
  return 0;
}

int pcd8544_backlight_on(void) {
  int ret = gpio_pin_set_dt(&pcd8544_gpios[BACKLIGHT], 1);
  if (ret < 0) {
    return ret;
  }
  return 0;
}

int pcd8544_deinit(void) {
  int ret = gpio_pin_set_dt(&pcd8544_gpios[BACKLIGHT], 0);
  if (ret < 0) {
    return ret;
  }
  return 0;
}
