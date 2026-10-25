# TM Vault

TM Vault is Kanto Reloaded Legacy's free move-teaching and move-relearning
interface. It replaces the Tutor.net pause-menu presentation without removing
Tutor.net's save fields, registration functions, NPC usage, or compatibility
with other mods.

## Pause Menu

When KIF adds `Tutor.net` to the pause menu, KR displays the command as
`TM Vault` and keeps KIF's icon on it (KIF's entry is
`  <icon=menuIcons/POKENAV>  Tutor.net`, so the label is matched with the icon
stripped). Selecting that command opens TM Vault after KIF's existing map
restriction check. Scripted calls to `PokemonTutorNetScreen` remain Tutor.net.

KIF's own `Tutor.net` option keeps its name in KIF Settings and continues to
control whether the pause-menu command is available.

## Registered Moves

TM Vault imports moves from `$Trainer.tutorlist`, scans the Bag for machines,
and listens for later `pbTutorNetAdd` calls. Tutor.net costs and currencies are
left intact for compatibility, but teaching through TM Vault is free.

Persistent data is stored in the KR `:tm_vault` system namespace:

- `moves`
- `sources`
- `sort_mode`
- `tutor_net_imported`

## Relearn Moves

Relearn mode starts with KIF's current
`MoveRelearnerScreen#pbGetRelearnableMoves` result. It then adds:

- Egg Moves when KIF's own `Egg Moves` option is enabled, so TM Vault and KIF's
  Move Relearner agree. TM Vault no longer has its own Egg Moves setting.
- Event Moves when KIF's existing `Event Moves` option is enabled.

TM Vault does not modify the party menu or KIF's Move Relearner.

Relearn Moves follows the active TM Vault sorting mode. Egg Moves display a
small Egg icon immediately to the left of their type icon. Type icons use
rounded corners throughout the move list.

## Controls

- `C`: Select a move, Pokemon, or filter.
- `B`: Return to the previous TM Vault state, then close from the main list.
- `A`: Select or clear a party compatibility filter.
- `Y`: Switch between TM Vault and Relearn Moves.
- `R`: Cycle Name, Type, Category, Recent, and Level Learned sorting.
- Up/Down: Move one list entry.
- Left/Right: Jump three list entries.
- Mouse wheel: Move the list only while the pointer is over the move list.
- `Z`: Open the Controls popup.

TM Vault always uses normal Pokemon icon graphics. KIF's global Big Icons
setting does not replace them with battler sprites.

`Level Learned` uses the selected Relearn or compatibility-filter Pokemon as
its context. Recorded first moves appear first, followed by level-up moves from
earliest to latest. Non-Egg moves without a level source follow those moves.
Egg Moves are grouped at the bottom and sorted by name.

## Public API

```ruby
KantoReloaded::TMVault.register(:THUNDERBOLT, :source => :script)
KantoReloaded::TMVault.open
KantoReloaded::TMVault.vault
KantoReloaded::TMVault.source_for(:THUNDERBOLT)
```

The module uses `KantoReloaded::Hooks` for every base-method integration.
