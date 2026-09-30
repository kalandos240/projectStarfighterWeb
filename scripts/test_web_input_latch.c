#include <assert.h>
#include <stdio.h>
enum { KEY_FIRE, KEY_UP, KEY_DUMMY, KEY_LAST };
static struct { int keyState[KEY_LAST]; } engine;
#include "../web/input-latch.h"
int main(void) {
    web_input_begin(); web_input_press(KEY_FIRE); web_input_release(KEY_FIRE);
    assert(engine.keyState[KEY_FIRE] == 1);
    web_input_begin(); assert(engine.keyState[KEY_FIRE] == 0);
    web_input_press(KEY_UP); web_input_begin(); assert(engine.keyState[KEY_UP] == 1);
    web_input_release(KEY_UP); assert(engine.keyState[KEY_UP] == 0);
    web_input_begin(); web_input_press(KEY_FIRE); web_input_release(KEY_FIRE);
    web_input_press(KEY_FIRE); web_input_begin(); assert(engine.keyState[KEY_FIRE] == 1);
    web_input_clear(); web_input_begin(); assert(engine.keyState[KEY_FIRE] == 0);
    web_input_press(KEY_DUMMY); assert(engine.keyState[KEY_DUMMY] == 0);
    puts("Short taps, held keys, repress and focus reset: PASS");
}
