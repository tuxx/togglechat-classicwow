# ToggleChat - WoW Classic 1.15.7 Addon

A simple addon that allows you to toggle the visibility of chat windows using a keybinding or slash commands.

## Features

- Toggle all chat windows on/off with a single key press
- Slash command support for easy access
- Persistent settings across sessions
- Compatible with WoW Classic 1.15.7

## Installation

1. Download or clone this repository
2. Copy the `ToggleChat` folder to your WoW Classic `Interface/AddOns/` directory
3. The path should look like: `World of Warcraft/_classic_/Interface/AddOns/ToggleChat/`
4. Restart WoW Classic or reload your UI (`/reload`)

### Reinstalling the Addon

If you're reinstalling the addon (especially after updates), it's recommended to clear the saved variables:

1. **Option 1: In-game command**
   - Type `/run ToggleChatDB = nil` in chat
   - Then `/reload`

2. **Option 2: Manual file deletion**
   - Navigate to: `World of Warcraft/_classic_/WTF/Account/[YourAccount]/[YourServer]/[YourCharacter]/SavedVariables/`
   - Delete the file `ToggleChat.lua`

3. **Option 3: Complete reset**
   - Navigate to: `World of Warcraft/_classic_/WTF/Account/[YourAccount]/[YourServer]/[YourCharacter]/SavedVariables/`
   - Delete the file `ToggleChat.lua`
   - Also delete the `ToggleChat.lua.bak` file if it exists

## Usage

### Slash Commands

- `/togglechat` or `/tc` - Toggle chat visibility
- `/togglechat help` - Show help information

### Keybinding

1. Open the Key Bindings menu (ESC → Interface → Key Bindings)
2. Look for the "ToggleChat" section
3. Set your preferred key for "Toggle Chat Visibility"

## Files

- `ToggleChat.toc` - Addon metadata and file list
- `ToggleChat.lua` - Main addon functionality
- `Bindings.xml`   - Key binding definition

## Settings

The addon saves the following settings:
- `showChat` - Current chat visibility state (default: true)
- `chatFrameSettings` - Individual chat frame visibility states

## Troubleshooting

If the addon doesn't work:
1. Make sure it's properly installed in the correct directory
2. Check that it's enabled in the AddOns list (ESC → Interface → AddOns)
3. Try reloading your UI with `/reload`
4. Check the chat for any error messages
5. If you're experiencing issues, try clearing saved variables (see "Reinstalling the Addon" section above)

## Compatibility

- WoW Classic 1.15.7
- Should work with other chat-related addons

## License

This addon is provided as-is for personal use. 
