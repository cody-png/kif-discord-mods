# Quick Throw

By Stonewall. Imported from the KIF Discord for KIF's Discord Mods catalog. This page describes version 1.5.1.

## What it does

- Throw a ball straight from the battle command menu (Fight / Bag / Pokémon / Run) with one key, without opening the Bag.
- Pick another ball from your Bag without leaving that menu.
- A Ball Info window with an estimated catch rate, a suggested ball and tips.
- Ball Memory: remembers which balls you caught each species with.
- A blacklist of balls for the mod to skip.

## Installing

Options > Mods > Browse > Discord Mods > Quick Throw. It starts working the next time the game starts. If Mods is greyed out, set Options > KIF Settings > Modules > Mod Settings to On first.

## How to use it

The keys work while you choose Fight, Bag, Pokémon or Run. The keys named here are the defaults; if you changed your key bindings, use yours.

- **Throw:** press the Special key (D). It throws the selected ball: the last ball you threw, a Poké Ball at first.
- **Pick another ball:** hold the Action key (Z or Shift) and press Left or Right to go through the balls in your Bag. A ball you throw from the Bag also becomes the selected ball.
- **Ball icon:** in PIF's own battle screen, the selected ball shows in the top-right corner while you have any of it.
- **Ball Info:** hold Action and press Up. With more than one foe, pick the foe first. It shows:
  - the turn and the foe's status,
  - the selected ball, its estimated catch rate and how many you have,
  - a suggested ball from your Bag, with its estimated catch rate,
  - with Ball Memory On, the ball you caught this species with most often, and how many times,
  - tips, for example a Quick Ball on the first turn, a Timer Ball in long battles, a Dream Ball on a sleeping foe.
  - Use, Back or Action closes it.
- **Suggested ball:** the ball you have with the best estimated chance, adjusted for the turn, the foe's status and type (for example a Net Ball on Bug and Water types). With Ball Memory On, if the ball you caught this species with most often has 3 or more catches and you have it, that ball is suggested instead.
- **Double battles:** with two foes, you choose which one to throw at; Back cancels.
- **Running out:** with none of the selected ball left, the key switches to Poké Balls (if you have any) instead of throwing. Press it again to throw one.

## Settings

Options > KIF Settings > Mods > Quick Throw settings > Quick Throw opens the mod's menu. Use or Left/Right changes a row, Back closes it. The settings, Ball Memory and the blacklist apply to every save file.

- **Quick Throw Mode:** Button (default), Menu or Off.
  - Button: the Special key throws.
  - Menu: no throw key. This mode is for a battle command menu from the author's own settings mod, which KIF doesn't have. Ball picking and Ball Info still work.
  - Off: none of the mod's keys work. In PIF's own battle screen the ball icon still shows; turn Quick Throw Sprite Off to hide it.
- **Quick Throw Sprite:** On (default). The ball icon in the corner.
- **Ball Info Screen:** On (default). Action + Up.
- **Ball Rotation:** On (default). Action + Left/Right.
- **No Balls Message:** On (default). A short message when you press the throw key with none of the selected ball left. Off switches to Poké Balls without it.
- **Ball Memory:** On (default). Counts each catch by species and ball.
- **Auto-Select Remembered:** Off (default). At the start of a battle, selects the ball you caught the foe's species with most often, if you have it. Needs Ball Memory On.
- **Ball Filters:** Off (default). On: blacklisted balls are skipped when you pick a ball, by Auto-Select Remembered, in the tips, and when the suggested ball is worked out (the remembered ball described under Suggested ball can still be suggested).
- **Doubles Target Select:** On (default). Off: a throw always goes to the first foe.
- **Manage Ball Blacklist:** every ball in the game. Use marks or unmarks one ([X] is on the blacklist). Clear All empties it. It only counts with Ball Filters On.
- **Reset Ball Memory:** forgets all remembered catches, after asking.

## Changes for KIF

- Works with EBDX Battles On. In the original, the keys did nothing in EBDX battles.
- KIF's Battle Info also uses the Action key. With Battle Info On and Quick Throw Mode on Button or Menu, it opens when you let go of Action, unless you pressed Left, Right or Up while holding it.
- The Quick Throw row in KIF's Mods settings opens the mod's menu.
- Each save file keeps its own selected ball, and it comes back after loading. Saves still load if you remove the mod.
- After you switch Pokémon, the command cursor goes back to Fight, as in the base game.

## Limits

- With EBDX Battles On, there is no ball icon and Auto-Select Remembered does nothing. Ball Info shows the selected ball.
- The catch rate is the mod's own estimate, not the game's roll.
- A quick throw skips the checks the Bag makes first, such as the full PC message, or that only your first Pokémon in a double battle can throw.
