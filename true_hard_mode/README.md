# True Hard Mode

By Loopy. Imported from the KIF Discord for KIF's Discord Mods catalog. This page describes version 1.0.1.

## What it does

Makes every trainer battle much harder. Only the opposing trainers' Pokémon change, and only for that battle. Wild battles, your Pokémon and a partner trainer's Pokémon are not changed.

- Stat boost: opposing Pokémon get 1.5x all stats, HP included (a Pokémon with Wonder Guard keeps its 1 HP), at 0 badges. This rises with your badges: 1.75x at 8, 2x at 16.
- The last Pokémon of each trainer gets another 1.2x on top.
- Raised base stats: a Pokémon whose base stats add up to less than a set total is raised to that total, keeping its stat spread. The total is 300 at 0 badges, 450 at 8 and 600 at 16.
- Max IVs in every stat.
- Six moves each (see below).
- A held item if it has none: Life Orb for attackers, Leftovers for bulky Pokémon, Weakness Policy for a bulky last Pokémon. Items the trainer already gave it are kept.
- Switch-in healing: a damaged Pokémon heals one eighth of its max HP each time it comes into battle, before entry hazards hit it. The game shows "The opposing <name> regained some health!".
- Fired up: once per battle, when one drops below half HP, it gets +1 to its better attacking stat and +1 to the best of its Defense, Sp. Def and Speed. The game shows "The opposing <name> is fired up!".
- Healing cooldown: after an opposing Pokémon uses a healing move, it can't pick any healing move for the next 2 turns. This covers Recover, Roost, Soft-Boiled, Slack Off, Milk Drink, Synthesis, Moonlight, Morning Sun, Shore Up, Heal Order, Rest and Wish.
- Contrary: on opposing Pokémon, Contrary still turns stat drops into boosts, but stat raises stay raises.

## The six moves

At the start of the battle each opposing Pokémon gets a new set of six moves:

- 3 attacks, one of them always a priority move (for example Quick Attack, Aqua Jet or Sucker Punch).
- The attacks come from moves it knows and moves it learns by level up to its level. It prefers moves that suit its better attacking stat, then stronger moves, with a bonus for moves of its own type.
- If that is not enough, it gets a strong move of its type (for example Flamethrower for Fire types, Earthquake for Ground types), then Body Slam or Hyper Voice. A missing priority move is filled by type (Mach Punch, Ice Shard, Aqua Jet, Shadow Sneak, Bullet Punch, Sucker Punch, Accelerock) or with Extreme Speed. These can be moves it could never learn.
- Some moves are never picked, for example Explosion, Self-Destruct, Hyper Beam, Giga Impact, Focus Punch, Fake Out and Last Resort.
- A setup move: one it already knows that fits its better attacking stat (Swords Dance, Bulk Up, Dragon Dance or Coil for physical attackers, Calm Mind, Nasty Plot or Quiver Dance for special attackers, Shell Smash for both). Otherwise Swords Dance (physical attackers) or Calm Mind (special attackers).
- A healing move: Recover, unless it already knows Roost, Soft-Boiled, Slack Off, Milk Drink, Synthesis, Moonlight, Morning Sun, Shore Up or Heal Order, which it keeps.
- A status slot that is chosen again every turn against the Pokémon it faces. It prefers Toxic against bulky Pokémon, then Will-O-Wisp against physical attackers, then Thunder Wave against Pokémon faster than it. Otherwise it takes the first that can work, in the order Toxic, Will-O-Wisp, Thunder Wave. It skips a move that your Pokémon's type or ability blocks or makes useless (for example Toxic against Steel types, Will-O-Wisp against Guts). If none can work (for example your Pokémon already has a status problem, or is behind a Substitute or Safeguard), the slot becomes another setup move. A move put into this slot starts with full PP.

## Installing

Options > Mods > Browse > Discord Mods > True Hard Mode. It starts working the next time the game starts. If Mods is greyed out, set Options > KIF Settings > Modules > Mod Settings to On first.

## How to use it

- Nothing to do. Every trainer battle uses it while the mod is on.
- Your badge count is read at the start of each battle.
- Both choices of the game's Battle AI setting (PIF and DemICE) follow the healing cooldown and use the changing status slot.

## Settings

None. The numbers are fixed.

## Stealing a trainer's Pokémon

When you steal a trainer's Pokémon with Rocket Mode, it becomes a normal Pokémon again at the end of the battle:

- The stat boost and raised base stats are removed. Its HP keeps the same share of its max HP.
- It keeps only its first four moves, usually its three attacks and its setup move.
- It keeps its max IVs, and the mod does not take back a held item it gave.

## Limits

- There is no way to make it easier, or to use it for some trainers only.
- Trainer Pokémon can have moves they could never learn.

## Credits

- Loopy, who made the mod.
