/* Preserve a short press for one poll, even when down/up arrive together. */
#ifndef STARFIGHTER_INPUT_LATCH_H
#define STARFIGHTER_INPUT_LATCH_H
static unsigned char webInputPressed[KEY_LAST];
static unsigned char webInputReleasePending[KEY_LAST];
static void web_input_begin(void) {
    for (int key = 0; key < KEY_LAST; ++key) {
        if (webInputReleasePending[key]) engine.keyState[key] = 0;
        webInputReleasePending[key] = 0;
        webInputPressed[key] = 0;
    }
}
static void web_input_press(int key) {
    if (key < 0 || key >= KEY_LAST || key == KEY_DUMMY) return;
    engine.keyState[key] = 1;
    webInputPressed[key] = 1;
    webInputReleasePending[key] = 0;
}
static void web_input_release(int key) {
    if (key < 0 || key >= KEY_LAST || key == KEY_DUMMY) return;
    if (webInputPressed[key]) webInputReleasePending[key] = 1;
    else engine.keyState[key] = 0;
}
static void web_input_clear(void) {
    for (int key = 0; key < KEY_LAST; ++key) {
        engine.keyState[key] = 0;
        webInputPressed[key] = 0;
        webInputReleasePending[key] = 0;
    }
}
#endif
