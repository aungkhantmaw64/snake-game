FROM debian:bookworm-slim

RUN apt-get update --fix-missing && apt-get install -y --no-install-recommends zsh git cmake \
    ninja-build gperf ccache dfu-util device-tree-compiler wget \
    python3-dev python3-pip python3-setuptools python3-tk python3-wheel python3-venv \
    xz-utils file make gcc gcc-multilib g++-multilib libsdl2-dev libmagic1 minicom xxd usbutils

RUN sh -c "$(wget https://raw.githubusercontent.com/ohmyzsh/ohmyzsh/master/tools/install.sh -O -)"

RUN python3 -m venv ~/zephyrproject/.venv && \
    . ~/zephyrproject/.venv/bin/activate && \
    pip install west && \
    west init ~/zephyrproject && \
    cd ~/zephyrproject && west update && west zephyr-export && \
    pip install -r ~/zephyrproject/zephyr/scripts/requirements.txt

RUN wget https://github.com/zephyrproject-rtos/sdk-ng/releases/download/v0.16.5/zephyr-sdk-0.16.5_linux-x86_64.tar.xz

RUN wget -O - https://github.com/zephyrproject-rtos/sdk-ng/releases/download/v0.16.5/sha256.sum | shasum --check --ignore-missing && \
    tar -xvf zephyr-sdk-0.16.5_linux-x86_64.tar.xz && rm -rf zephyr-sdk-0.16.5_linux-x86_64.tar.xz

RUN cd zephyr-sdk-0.16.5 && yes | ./setup.sh

WORKDIR /root/zephyrproject/zephyr/app

COPY ./entrypoint.sh /root/zephyrproject/zephyr/app

RUN chmod +x /root/zephyrproject/zephyr/app/entrypoint.sh

RUN echo "source ~/zephyrproject/.venv/bin/activate" >> ~/.zshrc

ENV ZEPHYR_PATH=/root/zephyrproject
ENV ZEPHYR_BOARDS_PATH=${ZEPHYR_PATH}/zephyr/boards
ENV FW_PATH=${ZEPHYR_PATH}/zephyr/app

ENTRYPOINT [ "/root/zephyrproject/zephyr/app/entrypoint.sh" ]
