# Journey Camera & Perspective

By Copilot. Imported from the KIF Discord for KIF's Discord Mods catalog. This page describes version 1.1.1.

## What it does

- Zooms the overworld camera out, so you see more of the map around you.
- Horizon Perspective: an optional tilted view. The ground bends toward a horizon near the top of the screen, and people and objects get smaller the higher up the screen they are.
- Adaptive Widescreen: in a wide window, or fullscreen on a wide monitor, the overworld and battles get a wider view. The picture is not stretched.
- The Journey Camera, a key item you buy at a PC. Take photos of each area and its landmarks, keep them in an album, and fill in a checklist for every map.
- Photos can also be taken during battles.

## Installing

Options > Mods > Browse > Discord Mods > Journey Camera & Perspective. It starts working the next time the game starts. If Mods is greyed out, set Options > KIF Settings > Modules > Mod Settings to On first.

## How to use it

### Zoom, perspective and widescreen

- All three start Off. With all three Off, the map looks and plays like the normal game.
- Turn them on in the settings (see Settings below). Changes show when you close the pause menu, or when you load a save.
- Zoom Out and Horizon Perspective work together or on their own.
- Adaptive Widescreen only takes effect when the window is about 1.7 times as wide as it is tall or wider (a 16:9 window or screen is enough). The view then grows from 16 to 21 tiles across.
- When you resize the window or switch to fullscreen on the map, the view adjusts by itself a moment after you stop.
- At the title screen the game goes back to the normal screen size.

### Journey Camera

- **Getting it:** use a PC that asks which PC to use, such as the one in a Pokémon Center, and pick Journey Camera. The PC in your room does not list it. It costs $12 and goes into your Key Items pocket. After that, the same PC entry opens Journey Overview, Journey Collection, Journey Album and Tips.
- **Opening it:** pick Camera in the pause menu, or choose Open Camera on the Journey Camera in the Bag. The menu has Take Photo, Journey Overview, Journey Collection, Journey Album and Tips.
- **Take Photo:** saves a picture of the screen, with a shutter sound and a white flash.
  - Every area has one Scenic Shot.
  - If you face a named person or object, or stand within one tile of where one is placed on the map, you can pick a Landmark Shot of it instead.
- **Journey Overview:** your current area and its progress, your progress across all areas, how many photos you have, and the landmarks near you.
- **Journey Collection:** every area with its progress, for example [1/4]. Areas that share a name are grouped. Pick an area (in a group, then one of its maps) to see its checklist ([x] done, [ ] not yet). Pick a done target to see its photo, or View Map Album for all photos of that map.
- **Journey Album:** newest photo first. Left and Right browse. Use switches full screen on and off. Back leaves full screen first, then the album. Each photo shows what it is, where it was taken, and the date and time.
- **In battle:** in normal trainer and wild battles, open the Bag and use the Journey Camera to take a battlefield photo. It takes your turn, but the camera is not used up. Battle photos go into the album but do not count for checklists.
- **Where photos are kept:** as picture files in a folder named LocationPhotos in your save folder, one folder per trainer. The album list and checklists are part of your save file.

## Settings

Options > KIF Settings > Mods > Journey Camera & Perspective settings. The same rows are under Settings by category > Interface. They apply to every save file.

- **Zoom Out (%):** 0 to 100 in steps of 10. Default 0, the normal view. Higher numbers show more of the map. At 100 the map is drawn at half size.
- **Horizon Perspective:** Off or On. Default Off. The author calls it experimental.
- **Adaptive Widescreen:** Off or On. Default Off.
- **Perspective Options:** opens the mod's own screen with the same three settings, called Zoom Out (%), Experimental Horizon Perspective and Adaptive Widescreen there, each with a longer description. Your choices are saved when you close that screen.

## Changes for KIF

- The original did not load in KIF 1.1. The parts that did not fit this version of the game were fixed, such as the pause menu and the way back to the title screen.
- The original's settings entry never showed up in this version's Options screen. The settings are now in Options > KIF Settings > Mods and are kept for all save files.
- With every option Off, the game draws the map and characters its own way.
- Zoom and perspective work with KIF's frame rate setting above 40 fps.
- Underwater tiles and events meant to sit below the player now draw in the right order while zoomed.
- Adaptive Widescreen only looks at the game's own window. Before, switching to another program could make it read that program's window.
- With Adaptive Widescreen on and KIF's Map Zoom (Options > Graphics) set to Far, the player is in the middle of the screen and the camera stops at map edges. Before, the player was drawn in the top-left part of the screen.
- The Journey Camera is left out of save files and put back when the save loads. A save made with this mod still loads cleanly after you remove it, with no unknown item in the Bag. Install the mod again and the camera, your photos and your checklists come back.
- The album no longer shows "Photo unavailable" for every photo when the game folder has no cache folder yet.

## Works with other mods

- Multiplayer: if a multiplayer mod's options screen has a Map Zoom row, this mod hides that row, as long as that mod loads before this one. Use Zoom Out here instead.

## Limits

- Landmarks come from the names the map makers gave to events on each map, not real place names. Many are odd (for example lights, cutscene triggers and lily pads), some appear several times, and some are invisible. Full checklists are hard to finish.
- Journey Collection lists every map in the game files, including places you may never reach.
- Your first Landmark Shot in an area also ticks that area's Scenic Shot. Until you take a real Scenic Shot there, picking it in the checklist says you have not taken it yet.
- The first time in a session you open Journey Overview or Journey Collection, the game reads every map, so it may pause for a moment.
- The Camera row appears only once you own the camera. It sits at the bottom of the pause menu, below Title, and has no icon.
- While the wide view is on, menus and other screens use the wider screen too. Screens made for the normal width may leave empty space at the side.
- Photos you delete or move out of the photo folder show as "Photo unavailable" in the album.
- In some special battles the camera says it can't be used.

## Credits

- Journey Camera & Perspective by Copilot, shared on the KIF Discord.
