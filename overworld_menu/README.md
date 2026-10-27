# Overworld Menu

By Stonewall. Imported from the KIF Discord for KIF's Discord Mods catalog. This page describes version 2.0.1.

Based on the author's notes, rewritten for KIF.

## What it does

- Adds a small quick menu that you open on the map with one key (Q with the game's default keys).
- The list sits in the top right corner and has two pages.
- Built-in entries:
  - **Time:** sets the time of day to Morning, Afternoon, Evening or Night.
  - **Mod Settings:** opens KIF's mod settings.
- A party view on the left shows your party in a grid of two columns and three rows. For each Pokémon:
  - its icon and level,
  - its HP as numbers and as a bar: green above half, yellow above a quarter, red below that,
  - a status icon, also for fainted and Pokérus,
  - a star if it is shiny, and the item it holds.
  - Eggs show as EGG.
- Other mods made for this menu can add their own entries.

## Installing

- Options > Mods > Browse > Discord Mods > Overworld Menu.
- It starts working the next time the game starts.
- If Mods is greyed out, set Options > KIF Settings > Modules > Mod Settings to On first.

## How to use it

- On the map, press the open key. The menu does not open while you are walking, in a battle, during a message, inside another menu, or while you are moving furniture.
- Up and Down move the cursor. The confirm key (C by default) picks an entry.
- W switches between Page 1 and Page 2. Page 2 is empty until you move entries there; an empty page shows "No items on this page".
- The Back key (X by default) or the open key closes the menu.
- Up to 8 entries show at once. The list scrolls if there are more.
- **Time:** pick Morning (5 AM), Afternoon (2 PM), Evening (5 PM) or Night (8 PM). The clock moves forward to that hour. If the hour has already passed today, it moves to that hour on the next day. The menu closes after you pick. Back returns to the list.
- **Mod Settings:** closes the menu and opens Options > KIF Settings on the Mods page.

## Settings

The Overworld Menu Settings screen opens from:

- Options > KIF Settings > Mods > Overworld Menu settings > Overworld Menu.
- Options > KIF Settings > Mods > Settings by category > Interface > Overworld Menu.

Its rows:

- **Enabled** (Off / On, default On): while Off, the open key does nothing.
- **Open Button** (default Q / (L)): opens a list of single keys and key pairs. For a pair, hold both keys.
- **Party View** (Off / On, default On): shows or hides the party view.
- **Weather Box** (Off / On, default On): see Limits.
- **Time Page** and **Mod Settings Page** (Page 1 / Page 2, default Page 1): which page the entry is on. Entries added by other mods get a Page row of their own.

The settings apply to every save file.

## Changes for KIF

- It loads fully without other mods. The original needed a part of the author's Mod Settings mod. Without it, KIF showed a load error for the mod and its settings screen was missing.
- The Mod Settings entry opens KIF's own mod settings. In the original it only said "Mod Settings not available."
- The shiny star in the party view shows. The original looked for its picture in the wrong folder.
- The menu does not open while you are moving furniture, since Q and W turn the furniture then.
- The author's own update check is removed. Updates come through Options > Mods.

## Works with other mods

- Mods written for this menu can add entries to it. A new entry starts on Page 1.
- Kanto Reloaded Legacy has a newer Overworld Menu of its own built in. The two get in each other's way, so use only one of them.

## Limits

- The key names in the Open Button list come from an older game version. With KIF's default keys, A / (Y) is the same key as Q / (L) (the Q key), and S / (LS) is the same as W / (R) (the W key). Pairs follow the same rule: Q + A is just Q, W + S is just W, Q + S and W + A are both Q + W, A + Z is Q + Z, and S + Z is W + Z.
- After you pick a key, the Open Button row shows it the next time you open the settings screen. It always names Q and W, never A and S.
- W always switches pages inside the menu. If your open key uses W, close the menu with the Back key.
- With Options > KIF Settings > Game > Speed-up > Type set to Toggle, KIF uses Q (next speed) and W (back to normal speed) on the map. If your open key uses Q or W, opening the menu with it changes the game speed too.
- The weather box needs the author's separate Weather System mod, which is not in the Discord Mods catalog. Without it, the Weather Box setting changes nothing.
