# pbGainMoney Base

By Ceadeus. Imported from the KIF Discord for KIF's Discord Mods catalog. This page describes version 1.0.1.

## What it does

- A base for other mods that change the money you get from battles. On its own it changes nothing you can see.
- It splits the step at the end of a won battle, where you get paid, into small parts:
  - the checks for whether you get paid at all (no money for rematches, or in battles that give no money)
  - the trainer's prize money
  - the Amulet Coin and Happy Hour doubling
  - picking up the money scattered by Pay Day
  - the "You got $... for winning!" and "You picked up $...!" messages
- Other mods can then each change one part, for example a money multiplier or money for rematches, without undoing each other.
- Prize money, Amulet Coin, Happy Hour and Pay Day work the same as without the mod.
- The author made it for mods such as money on rematches, a money multiplier, a different Amulet Coin effect, a different prize money formula and a Pay Day change. Those mods are separate and are not included.
- This page is based on the author's notes. The author lets others use and edit it in their own projects.

## Installing

- Options > Mods > Browse > Discord Mods > pbGainMoney Base.
- It starts working the next time the game starts.
- If Mods is greyed out, set Options > KIF Settings > Modules > Mod Settings to On first.

## How to use it

- There is nothing to press or set. It has no menu and no settings.
- Install it when a mod you want is built on it.

## Changes for KIF

- Fits KIF 1.1's end-of-battle money step. When a won battle also gives Glimmer Coins, the message names both the money and the Glimmer Coins, the same as without the mod.
- Like the base game, KIF's PC self battles give no money.

## Works with other mods

- Kanto Reloaded Legacy: its Battle Money bonus (Battle Multiplier) and its Rematch Money option do nothing while this mod is installed. Both add to the same end-of-battle step, and this mod replaces that step after Kanto Reloaded Legacy has loaded.
- KIF's message about EV points to spend still shows after a win or a catch.

## Limits

- It does nothing useful unless another mod is built on it.
- Other mods that change battle money without being made for this base can stop working while it is installed (see Kanto Reloaded Legacy above).
- Only the money you get for winning is split up. The money you lose when you lose a battle is not part of it.
- The game works out the Glimmer Coins amount before this step, so changing the parts of this base does not change it.
