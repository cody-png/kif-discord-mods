# PokeVial

`Modules/PokeVial.rb` is a standalone Kanto Reloaded Legacy module that
replaces KIF's unlimited `Heal Pokemon` pause command with limited party
healing.

It does not provide REPM integration, custom items, grant APIs, reward handlers,
shared callbacks, Reloaded Mart support, or Mystery Gift support.

## Settings

PokeVial's settings are rows in KIF Settings under KR Legacy's `PokeVial`
heading. The other eight sit under the `PokeVial` switch and hide while it is
Off.

- `poke_vial_enabled`: enables the replacement; default On
- `poke_vial_progressive`: raises maximum charges every two Badges; default On
- `poke_vial_max_uses`: manual maximum from 1 to 5 when progression is Off
- `poke_vial_heal_mode`: Full Heal or HP Only
- `poke_vial_cooldown`: enables a real-time delay between uses
- `poke_vial_cooldown_time`: 5 through 45 minutes
- `poke_vial_refill_mode`: Ask, Automatic, or Never for PokeCenter refills
- `poke_vial_refill_cost`: enables PokeCenter refill costs
- `poke_vial_cost_per_charge`: cost for each missing charge

KIF Settings does not grey out rows that do not apply, so they stay
changeable but have no effect: Manual Max Uses during Progressive Uses,
Cooldown Time while Cooldown is Off, and Cost Per Charge while PokeCenter Cost
is Off.

When PokeVial is disabled, the pause-menu wrapper delegates unchanged and KIF's
native Heal Pokemon command returns.

## Save Data

PokeVial stores only these values in KR's `poke_vial` system bucket:

- `uses`
- `last_use_time`
- `progressive_max_seen`

Settings remain in KR's normal settings bucket. No Pokemon instance data or
base save classes are changed.

## Pause Menu

The module guard-wraps `PokemonPauseMenu_Scene#pbShowCommands`. It replaces an
existing Heal Pokemon row in place and keeps KIF's icon on it. If KIF does not
provide that row, PokeVial is inserted after PC, or after Pokemon when PC is
absent. KIF's pause labels carry `<icon=...>` markup, so rows are matched with
the icon stripped.

The wrapper keeps an explicit display-to-original index map. PokeVial
selections are consumed inside the wrapper, while every other selection returns
the original command index. This preserves the alias chains used by TM Vault
and installed Multiplayer pause-menu additions without editing those systems.

The displayed pause-menu label includes the current charge status without
showing cooldown text. The Overworld Menu status may still show cooldown state.
A charge is not consumed when the party has nothing to restore.

Successful healing and PokeCenter refills use KR's success toast. Expected
denials use warning toasts, while healing and payment failures use error toasts.

Selecting PokeVial while cooldown is active opens a warning popup with a live
countdown. It can be dismissed normally and closes automatically when the
PokeVial becomes ready. If the system clock moves backward, PokeVial corrects
the saved timestamp and limits the wait to one configured cooldown period.

## Healing and Refills

Full Heal restores HP, status, and PP. HP Only restores HP. Eggs are ignored by
KIF's native Pokemon healing methods.

PokeVial preserves the old game's restricted-map list for its former Heal
Pokemon command and also blocks Safari, Bug Contest, and battle use. The list
holds Kanto map numbers (Elite Four, Mt. Silver, and others), so no map is
blocked in PIF's Hoenn game (`Settings::HOENN`), where those numbers are other
maps. The `DemICE.krs` bypass remains supported.

PokeCenter recovery is identified through a guarded wrapper around
`command_314` on every available KIF interpreter class. This supports the
native `Interpreter` class and JoiPlay hosts that expose `Game_Interpreter`.
The native Recover All command runs first and retains its return value, then
PokeVial performs its refill check directly without depending on
`Trainer#heal_party` chaining.

The current registered PokeCenter map remains the primary location check.
PokeCenter map metadata and normalized map names provide portable fallbacks
when a JoiPlay save has not synchronized that map ID. Ask mode prompts before
restoring missing charges, Automatic mode refills without a confirmation, and
Never mode skips refills. The refill result reports both restored charges and
any money spent. PokeVial's own healing cannot trigger a refill.

Successful PokeVial healing plays KIF's `Recovery` sound. With Progressive Uses
enabled, every two Badges unlock one additional maximum charge. The newly
unlocked charge is filled once and announced with a success toast. A saved
capacity marker prevents repeated grants if Badges or settings later decrease.

## Overworld Menu

PokeVial registers a default-visible Overworld Menu command with charge,
cooldown, or empty status. It uses the same settings, charge state, restrictions,
and healing path as the pause-menu command.
