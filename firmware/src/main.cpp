#include <pico/stdlib.h>
#include <iostream>

#include "main.hpp"

/** Define the prototypes in this namespace (probably should do this in a different file).
 *  If you do make another file, make sure to add it's c/cpp file to the CMakeLists.txt SOURCE_FILE setter
 *  */ 
namespace lush::rp2040 {

    void printHelloWorld() {
        std::cout << "Hello, World!" << std::endl;
    }

}

/** @brief The entry point of the program
 *  @note  Args not included, and I recommend not even bothering with it :)
 *  @returns Probably shouldn't return unless something bad has happened and you have a debugger attached to see it 
*/
int main() {

    stdio_init_all();

    while (true) {

        lush::rp2040::printHelloWorld();

        sleep_ms(1000);
    }
}