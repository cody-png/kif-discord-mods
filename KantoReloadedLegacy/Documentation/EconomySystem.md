# Economy System

The Economy System adds configurable new-game and battle money and paid
Reloaded PC services. It has no master switch: Each feature has its own
setting in KIF Settings, under KR Legacy's `Money` heading (Starting Money,
Battle Money with Battle Multiplier under it) and `PC` heading (Reset EVs and
Friendship Boost, each with its price under it).

Mart Events and the Economy System master switch are gone. The Regular Mart and
the shop screens no longer build Mart Event contexts, and Mart Events no longer
has an Overworld Menu entry.

## Money

Starting Money is a global new-game amount and defaults to `$3,000`. It is
assigned after the game creates the new Trainer and does not alter existing
saves. In KIF Settings it is a slider from `$0` to `$9,999,999` in steps of
`$100`.

Battle Money defaults to On at `1x` and supports `1x-10x`. KIF completes its
native payout first. KR measures the actual money gained and adds only the
configured extra amount, preserving native trainer payout, Pay Day, Amulet
Coin, Happy Hour, rematch, and money-cap behavior.

## Paid PC Services

When Reloaded PC is active, the `Reloaded Actions` submenu directly below
`Kuray Actions` includes:

- Reset EVs: resets all EVs for `$1,000` by default
- Friendship Boost: adds 50 friendship, capped at 255, for `$5,000` by default

In KIF Settings both prices are sliders from `$0` to `$999,999` in steps of
`$100`, shown under their service while it is On. Friendship Boost previews
both the current and resulting friendship before the player confirms payment.

Each service checks eligibility and funds before confirmation, charges only
after the Pokemon update succeeds, refreshes the active PC scene, and returns
to the `Reloaded Actions` submenu. Eggs are not eligible.

## Public API

`KantoReloaded::EconomySystem` exposes `reset_ev_price` and
`friendship_price`. The Mart Event context and its developer controls are gone.

The Economy System keeps no save data of its own beyond its settings. Admin
controls are intentionally kept in the separate Admin Control mod. When Admin
Control is installed, Reloaded regular Marts expose Economy Control directly
from their Buy/Sell/Quit prompt.
