# ZMK config for Agar Mini BLE

The personal keymap is [`config/agar_mini_ble.keymap`](config/agar_mini_ble.keymap).
It is built for the split 3U + 3U spacebar layout.

## Keymap

- Base: Tab above the dedicated Control left of A, Option and Command on the
  left bottom row, Command and Esc on the right bottom row. Right Space is plain
  Space.
- Hold left Space for numbers and symbols: Q–P produce 1–0, H/J produce `[ ]`,
  semicolon produces `'`, and period produces `/`. Shift gives `{ }` and `?`.
- Hold the Utility key at the far right of the bottom letter row for HHKB-style
  arrows: P/L/semicolon/period are up/left/right/down. Utility+Tab produces
  backtick (Shift adds `~`); Utility+A/F/D control volume down/up/mute;
  Utility+H/J send Command-Shift-[ / Command-Shift-] for previous/next tab;
  Utility+S enters the bootloader.
- Hold Utility and press the key printed `4` (R) for a selected area screenshot
  (Command-Shift-4), or the key printed `5` (T) to open the macOS capture and
  recording toolbar (Command-Shift-5). Left Space is not needed.
## Local build

Run `mise run setup` once, then `mise run build`. The Zephyr SDK, download cache,
Python environment, and build output remain inside this repo. The firmware is
written to `dist/agar_mini_ble-klink-zmk.uf2`.
