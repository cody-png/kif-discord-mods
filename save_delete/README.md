# Save Delete

By Stonewall. Imported from the KIF Discord for KIF's Discord Mods catalog. This page describes version 1.0.1.

## What it does

- Lets you delete a save straight from the load menu with one key.
- A deleted save is not erased. It is moved into a folder named DELETED SAVES inside your save folder, together with any other files there that are named after that save.
- A Save Delete Settings screen lets you bring a deleted save back, empty the DELETED SAVES folder for good, or open that folder on Windows.

## Installing

- Options > Mods > Browse > Discord Mods > Save Delete.
- It starts working the next time the game starts.
- If Mods is greyed out, set Options > KIF Settings > Modules > Mod Settings to On first.

## How to use it

Deleting a save:

- On the load menu, select the save panel (the one with the save name, such as File A). Use Left and Right to pick the save you want.
- Press D. D does nothing while the language icon above the panel is selected.
- The game asks if you want to delete that save, tells you how many files will be moved, then asks "Are you absolutely sure?". Say No at either question to keep the save.
- After the move it says how many files were moved, and the load menu shows the first save you still have, or no save if none are left.

Restoring a deleted save:

- Open Save Delete Settings and choose Restore Deleted Saves.
- Pick a save from the list and confirm.
- If the save's own slot is free, it goes back there.
- If that slot is in use, or the save was kept with a number added (see below), it offers the first free slot from File A to File H instead. If every slot is in use, nothing is moved.

## Settings

The Save Delete Settings screen opens from:

- The load menu: Save Delete Settings, in the list below Options.
- Options > KIF Settings > Mods > Save Delete settings > Save Delete Settings.
- Options > KIF Settings > Mods > Settings by category > Quality of Life > Save Delete Settings.

The screen shows how many files are in DELETED SAVES and how much space they use. Its choices:

- **Restore Deleted Saves:** puts a deleted save back (see above).
- **Clean Up Deleted Saves:** permanently deletes every file in DELETED SAVES. It asks twice. This cannot be undone.
- **View Deleted Saves Folder:** on Windows, opens the folder in File Explorer. On other systems and on phones it shows the folder's path. The folder is made if it does not exist yet.
- **Back:** closes the screen.

## Changes for KIF

- The load menu stays KIF's own. The original replaced the whole load menu with an older version, which lost newer parts such as Savefile management and the language icon.
- Nothing is overwritten. If DELETED SAVES already has a save with the same name, the new one is kept beside it with a number added, such as File A~2. A restore never goes into a slot that is in use.
- The autosave count in the first question is now right, and the "Moved" message afterwards counts only the files that moved.

## Limits

- The older backups of a save, the ones Savefile management > Load an older backup uses, are not moved or deleted.
- After a restore from the load menu, the menu does not switch to the restored save. Press Left or Right on the save panel until it comes up. If no save was left on the menu, it shows up the next time the game starts.
- Clean Up Deleted Saves removes every file in DELETED SAVES, including files you put there yourself.
- With Kanto Reloaded (or another mod settings menu mod) installed, Save Delete Settings is not listed under Options > KIF Settings > Mods. Open it from the load menu instead.
