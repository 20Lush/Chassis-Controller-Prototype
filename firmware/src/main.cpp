#include "main.hpp"

#include <pico/stdlib.h>
#include "hardware/pwm.h"
#include "hardware/clocks.h"

#include <iostream>
#include <string>

#include "Adafruit_NeoPixel.hpp"

/** Define the prototypes in this namespace (probably should do this in a different file).
 *  If you do make another file, make sure to add it's c/cpp file to the CMakeLists.txt SOURCE_FILE setter
 *  */
namespace lush::rp2040 {

	void printHelloWorld() {
		std::cout << "Hello, World!" << std::endl;
	}

    float measure_duty_cycle(uint gpio) {
        // Only the PWM B pins can be used as inputs.
        //assert(pwm_gpio_to_channel(gpio) == PWM_CHAN_B);
        uint slice_num = pwm_gpio_to_slice_num(gpio);

        // Count once for every 100 cycles the PWM B input is high
        pwm_config cfg = pwm_get_default_config();
        pwm_config_set_clkdiv_mode(&cfg, PWM_DIV_B_HIGH);
        pwm_config_set_clkdiv(&cfg, 100);
        pwm_init(slice_num, &cfg, false);
        gpio_set_function(gpio, GPIO_FUNC_PWM);

        pwm_set_enabled(slice_num, true);
        sleep_ms(10);
        pwm_set_enabled(slice_num, false);
        float counting_rate = clock_get_hz(clk_sys) / 100;
        float max_possible_count = counting_rate * 0.01;
        return pwm_get_counter(slice_num) / max_possible_count;
    }

    const int LED_PIN = PICO_DEFAULT_WS2812_PIN;

    const int MEASURE_PIN = 2;

}  // namespace lush::rp2040

/** @brief The entry point of the program
 *  @note  Args not included, and I recommend not even bothering with it :)
 *  @returns Probably shouldn't return unless something bad has happened and you have a debugger attached to see it
 */
int main() {

	stdio_init_all();

    Adafruit_NeoPixel pixel(1, lush::rp2040::LED_PIN, NEO_GRB + NEO_KHZ800);
    pixel.begin();
    pixel.setBrightness(20);

	while (true) {

		lush::rp2040::printHelloWorld();

        pixel.fill(0xFF0000);
        pixel.show();

		sleep_ms(500);

        pixel.fill(0x000FF0);
        pixel.show();

        sleep_ms(500);
	}
}