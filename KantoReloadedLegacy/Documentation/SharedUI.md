# Kanto Reloaded Legacy Shared UI

Kanto Reloaded Legacy provides a shared UI foundation in `Core/UI`. Its
settings appear in KIF Settings through `Core/Compatibility/KIFSettings.rb`
(see `Settings.md`). Legacy no longer restyles the game's own option scenes or
adds entries to the game's Options menu.

## Public APIs

- `KantoReloaded::PopupWindow.message(text, options = {})`
- `KantoReloaded::PopupWindow.confirm(text, options = {})`
- `KantoReloaded::PopupWindow.choice(title, commands, options = {})`
- `KantoReloaded::PopupWindow.carousel(title, entries, options = {})`
- `KantoReloaded::PopupWindow.progress(text, options = {}) { |progress| ... }`
- `KantoReloaded::NumberPicker.open(title, min:, max:, initial:)`
  Supports optional `digit_suffixes`, `validator`, `invalid_message`,
  `result_transform`, and `on_update` values for formatted, constrained pickers
  such as Time Changer's `0d 0000h` control.
- `KantoReloaded.number_picker(title, min:, max:, initial:)`
- `KantoReloaded::Toast.show(text, options = {})`
- `KantoReloaded::Toast.success(text, options = {})`
- `KantoReloaded::Toast.warning(text, options = {})`
- `KantoReloaded::Toast.error(text, options = {})`
- `KantoReloaded::Toast.custom(title, rows = [], options = {})`
- `KantoReloaded::HintText.draw_footer(bitmap, entries, x, y, width, options = {})`
- `KantoReloaded::HintText.open_popup(title, entries, options = {})`
- `KantoReloaded::SettingsUI.open`
- `KantoReloaded::SettingsUI.open_category(category_id)`
- `KantoReloaded::SettingsUI.open_module(module_id)`
- `KantoReloaded.open_settings`
- `KantoReloaded.open_module_settings(module_id)`
- `KantoReloaded.message(text, options = {})`
- `KantoReloaded.confirm(text, options = {})`
- `KantoReloaded.toast(text, options = {})`
- `KantoReloaded.toast_success(text, options = {})`
- `KantoReloaded.toast_warning(text, options = {})`
- `KantoReloaded.toast_error(text, options = {})`

The top-level message helpers use KR's shared popup and toast UI when it is
available, with guarded KIF message fallbacks for early boot or reduced UI
runtimes.

## Old Settings Scenes

The `SettingsUI` entry points above open the old KR settings scenes. They are
still in the code, but nothing in the game opens them anymore: Players change
Legacy's settings in KIF Settings.

The old scenes convert toggle, enum, number, slider, text, button, and custom
definitions into KR rows. Definitions retain their existing storage,
visibility, enabled-state, callback, and validation behavior.

Numeric definitions can set `metadata[:popup_picker]` to use the KR digit
picker while retaining numeric settings storage and Reset Module behavior.
Optional metadata includes `digits`, `picker_label`, and `value_prefix`. KIF
Settings doesn't use this metadata: A wide number range is a slider there.
KR settings scenes drain their closing input before returning to a parent scene,
matching the shared popup and picker behavior.

Action buttons are presented before value rows inside KR-owned category and
module scenes.

The main KR settings scene presents registered categories as collapsed headers:
Interface, Gameplay, Quality of Life, Economy, and Developer / Utility (empty
now). Confirm or a mouse click expands a header in place. Direct category and
module scene APIs remain available for mods that need to open a focused
settings page. The About rows, `File A Bug Report`, the Mod Settings scene, and
Save Manager are gone.

## Cursor Color

Of the old look settings only `Cursor Color` is left. It is a global setting
(`ui.cursor_theme`) and sets the cursor color of Legacy's own popups, lists,
and screens. Option Color, Category Color, Global Small Text, Menu Frame, and
Speech Follows Menu are gone with their font and frame hooks, so a fresh
install keeps the game's look.

## Input Rules

Keyboard, controller, mouse, and touch-capable runtimes share one input router.
Mouse hover changes selection only while the pointer moves or a mouse action is
active. Hover selection does not scroll the list; mouse-wheel input performs
mouse scrolling. A stationary pointer does not take selection away from
keyboard or controller input.

Left and Right adjust value rows only. They do not activate action buttons or
collapsible headers; use Confirm or a mouse click for those rows. Slider tracks
use half of the available value-area width to keep numeric values compact.
Mouse-wheel direction follows the list: Scrolling down advances downward and
scrolling up moves upward.

Popups own input while open and drain held Confirm, Back, and mouse inputs when
closing so input does not bleed into the underlying scene. Back is evaluated
before Confirm, so overlapping controller mappings always cancel instead of
activating the highlighted row. Confirmations default to Yes; destructive or
otherwise serious prompts opt into a No default with `serious: true` or an
explicit `default: false`.

`PopupWindow.progress` provides a non-interactive animated spinner over the
current scene. Long-running KR adapters can call `progress.pulse` at defined
work stages without creating a sequence of dismissible message windows.

`PopupWindow.carousel` provides a compact centered item carousel for shared
module workflows. Entries can supply `label`, `value`, `item`, `selectable`,
`details`, and `action_label`; these fields may be callables for live state.
Left/Right and the mouse wheel rotate one entry at a time, Confirm selects,
Back cancels, and the optional `on_action` callback is triggered by Action or
right-click. Item entries use KIF's animated `ItemIconSprite` centered in the
popup.

`NumberPicker` provides a popup-styled non-negative integer editor. Each
numeric position is an individual `0`-`9` slot. Left/Right selects a slot,
Up/Down or the mouse wheel changes its digit, Confirm advances through the
slots and submits from `OK`, and Back or right-click cancels. Mouse hover only
changes the selected slot while the pointer is active. Values outside `min`
and `max` remain editable but cannot be submitted.

KR popups use the Hoenn Reloaded treatment: A centered compact dark panel, dim
screen overlay, small text, blue title, gray/white rows, no text shadow, and a
pulsing rounded cursor. Popup hover follows the shared last-active-input rule.
