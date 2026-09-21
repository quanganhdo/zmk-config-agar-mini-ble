# ZMK config for Agar Mini BLE

The personal keymap is [`config/agar_mini_ble.keymap`](config/agar_mini_ble.keymap).
It is built for the split 3U + 3U spacebar layout.

## Keymap

- Base: dedicated Control left of A, Option and Command on the left bottom row,
  Command and dedicated Tab on the right bottom row. Right Space is plain Space.
- Hold left Space for numbers and symbols: Q–P produce 1–0, H/J produce `[ ]`,
  semicolon produces `'`, and period produces `/`. Shift gives `{ }` and `?`.
- Hold the Utility key at the far right of the bottom letter row for HHKB-style
  arrows: P/L/semicolon/period are up/left/right/down. Utility+Esc produces
  backtick (Shift adds `~`); Utility+H enters the bootloader.
- AeroSpace uses the dedicated Option key. For a workspace number, hold Option
  and left Space, then press the corresponding number-labeled letter key.

## Local build

Run `mise run setup` once, then `mise run build`. The Zephyr SDK, download cache,
Python environment, and build output remain inside this repo. The firmware is
written to `dist/agar_mini_ble-klink-zmk.uf2`.
