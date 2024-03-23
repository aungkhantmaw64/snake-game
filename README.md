# ZephyrRTOS-based Snake Game

A game about a snake chasing a dot.

## Getting Started

Build the docker image by running the following command:

```bash
docker build -t zephyr-project:0.16.5 --progress tty .
```

Then, to start and enter the container, run the following command:

```bash
docker container run --privileged --rm -it -v ${pwd}:/root/zephyrproject/zephyr/app zephyr-project:0.16.5 bash
```

> :exclamation: Windows hosts may need to run the following extra steps in order to connect the target device to the host via USB and wsl.

Install [usbipd-win](https://github.com/dorssel/usbipd-win) and then, run the following command to check the usb `busid` of the target device.

```bash
usbipd list
```

To connect the usb device to the desired linux distro from WSL, run the following command:

```bash 
usbipd attach --busid <busid> --wsl <distro>
```

## Build the firmware

To **build** the firmware, run the following command:

```bash
west build -p always -b nucleo_l152re
```

Once you have built the application, run the following command to **flash** it:

```bash
west flash
```

To build the **integration tests** with Twister, run the following command:

```bash
west twister -T tests --integration
```

To run unit tests using West, enter the test directory first. For example, if you want to test **gl** component of **lib**, go to tests/lib/gl.
Then, run the following command:

On Nucleo-L152RE
```bash
west twister --device-testing --device-serial /dev/ttyACM0 --device-serial-baud 115200 -p nucleo_l152re  -T tests
```