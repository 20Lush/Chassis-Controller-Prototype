# Welcome to a C++ template for rp2040 projects!
###  This project is a template for an embedded system using an rp2040
Relevant scripts are provided, similar to my other templates. This template works on the basis of using `pico-sdk` as well as `picotool` to handle hardware abstraction and uploading.

# Dependencies
This repo requires the use and full set up of `pico-sdk` (last known working ver 1.5.0) and `picotool`. I personally develop using a Raspberry Pi as a "build server" as well as a debugger. I suggest the same approach, as you will have enough of a headache figuring things out.

You will need these just for starters, and they are pretty heavy so install might take a while:
```bash
sudo apt install cmake gcc-arm-none-eabi libnewlib-arm-none-eabi libstdc++-arm-none-eabi-newlib build-essential pkg-config libusb-1.0-0-dev
```

### Brief procedure on installing dependencies under the cut...
<details> <summary><i><b>pico-sdk</b></i></summary>

1) navigate to `/usr/lib` - this will be where we clone the sdk to
2) `git clone https://github.com/raspberrypi/pico-sdk.git`
3) `sudo nano /etc/profile` and scroll all the way down
4) add `export PICO_SDK_PATH=/usr/lib/pico-sdk` then save and quit
5) `source /etc/profile` or reboot, your choice.

</details>

<details> <summary><i><b>picotool</b></i></summary>

1) navigate to `/usr/bin` - this will be where we clone picotool to
2) `git clone https://github.com/raspberrypi/picotool.git`
3) `cd picotool`
4) `mkdir build && cd build`
5) `cmake ..`
6) `make`
7) You may have to `make install` too. I can't remember.
8) `sudo cp udev/99-picotool.rules /etc/udev/rules.d/`
    * This is so you can just run picotool without having to use sudo all the time

</details>

## Building and uploading
You are primarily going to be working out of the `scripts/` directory, and all of the scripts need your working directory to be `scripts/` to do what they do correctly. The work flow is as follows:

1) run `./get_dependencies.sh`
2) Code your stuff
3) run `./format.sh`
4) Commit your stuff
5) run `./compile.sh -u`
    * `-u` is a flag that tells the build process to upload after a compilation
    * `-c` is another useful flag that will UNSAFELY delete `build/` which can be used to get out of any ninja or cmake jam.
    * `-b` can be used like `-b Release` to target release build optimizations, as the build process is defaulted to `Debug`

