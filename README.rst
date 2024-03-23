ZephyrRTOS-based Snake Game
###########################

.. contents::
   :local:
   :depth: 2

Getting Started
***************

Building the docker image
=========================

.. code-block:: 

    docker build -t zephyr-project:0.16.5 --progress tty .

Running the container
=====================

Windows

.. code-block::

    usbipd list

.. code-block::
    
    usbipd attach --busid <busid> --wsl <distro>

.. code-block::
    
    docker container run --privileged --rm -it -v ${pwd}:/root/zephyrproject/zephyr/app zephyr-project:0.16.5 bash


West
****

Build the firmware

.. code-block:: 

    west build -p always -b nucleo_l152re


