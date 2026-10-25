# Reloaded Shop

Kanto Reloaded Legacy replaces KIF's Kuray Shop purchase screen with the
offline `RLD Shop`. The `Regular Mart` option chooses between KIF's untouched
Standard interface and Kanto Reloaded Legacy's Reloaded buy and sell scenes. It
defaults to Reloaded.

The shop's rows sit in KIF Settings under KR Legacy's `Shops` heading: Regular
Mart, Confirm Purchases, Edit Shop Contents, Export Catalog, Import Catalog,
and Reset Reloaded Shop.

## Stock Ownership

KIF remains responsible for building the available Kuray Shop stock and prices.
This preserves badge requirements, Streamer's Dream behavior, Rocket Ball
availability, K-Egg progression, and other base-game conditions.

The catalog editor lists everything KIF's Kuray Shop can sell, by item symbol:
`KIF::KurayShop`'s own list (TMs by the move they teach), the Rocket Ball, then
the K-Eggs in their old order. The Hoenn K-Egg is left out because KIF no
longer sells it. K-Eggs are recognized through `KIF::KurayEggs.egg?`.

Kanto Reloaded Legacy stores a per-save customization overlay for:

- category names and order
- item categories and custom order
- added, removed, and disabled items
- buy and sell price overrides
- favorite items

Resetting RLD Shop clears only this overlay. The overlay keeps every entry
whether or not the player owns the item, and it lives in the save, so edits
stick once the game is saved.

## Owned TMs and HMs

KIF's Kuray Shop leaves out the important items (TMs, HMs) the player already
owns. The RLD Shop lists them again from `KIF::KurayShop::ITEMS`, in KIF's TM
order (`sort_tms`), and an owned TM or HM, including one added in the editor,
shows `OWNED` instead of its price. Choosing it says "You already have this
item." and nothing is bought.

## Controls

- Up/Down: select an item
- Left/Right: change category
- Confirm: buy or open editor actions
- Back: close
- Action: toggle favorite (RLD Shop only; it does nothing in a Regular Mart)
- Special: open the RLD Mart controls popup
- L: cycle sorting
- R: toggle Quick Buy

Purchasing uses the same centered Reloaded Mart quantity and confirmation
panels as Hoenn Reloaded. Regular Marts using the Reloaded interface have a
matching sell scene with category navigation, sorting, quantity selection,
and KR confirmations. Quick Sell is intentionally not provided. The
customizable RLD Shop remains buy-only.

Regular Mart Reloaded mode uses the exact stock and temporary prices supplied
by KIF, including randomized and progression-dependent stock. It never imports
RLD Shop catalog categories, favorites, custom stock, or custom prices.
The buy and sell scene header remains the short `Mart` label.

The Buy/Sell/Economy Control prompt is shown once per interaction. Returning
from any selected scene exits the Mart instead of reopening the prompt. The
Mart then says its own goodbye line; an empty goodbye (`""`) means none, as in
the game.

Bulk purchases in both RLD Shop and ordinary NPC Marts award one bonus item
for every complete group of ten in the current transaction:

- every 10 Poke Balls award 1 Premier Ball
- every 10 DNA Splicers or Super Splicers award 1 DNA Reverser
- every 10 DNA Reversers award 1 DNA Splicers
- every 10 Super Potions, Hyper Potions, or Max Potions award 1 Potion

Eligible Reloaded Shop quantity and confirmation panels preview the reward for
the selected quantity. Ordinary NPC Marts add the same preview to their native
purchase confirmation. A KR purchase-reward popup then reports the number of
bonus items added. If the Bag cannot hold the full reward, the popup reports
the partial or failed award.

Open the catalog editor with `Edit Shop Contents` in KIF Settings. The editor
uses Left/Right to change panels and Action to add a category or item.

## Import and Export

Catalog data is exported to:

`Mods/KantoReloadedLegacy/Exports/ReloadedShopCatalog.json`

The catalog is saved per save file, so Export Catalog followed by Import
Catalog in another save is how a customized catalog carries into a new game.
Import replaces that save's current catalog overlay. Both actions read and
write JSON through `KantoReloaded::Platform`, which falls back to the host's
bundled parsers because KIF's runtime does not ship Ruby's `json` library.

The feature is entirely local. It has no online catalog, publishing,
automation, services, promo codes, alternate currencies, timed stock, bundles,
or reward system.

## Compatibility

Runtime integration uses guarded KR hooks:

- `PokemonPauseMenu_Scene#pbShowCommands` changes only the `Kuray Shop` label to
  `RLD Shop`. KIF's pause entries carry an icon, so the label is matched
  without it and the icon stays.
- `PokemonMartScreen#pbBuyScreen` redirects only while KIF marks
  `$game_temp.fromkurayshop`.
- `pbPokemonMart` takes all five of KIF's arguments (stock, welcome line,
  cantsell, goodbye line, and "anything else?" line). Standard mode passes
  every one to KIF's original; the Reloaded Mart uses the stock, welcome line,
  cantsell, and goodbye line.
- Standard Mart hooks track the selected item and quantity, then award bonuses
  only after `PokemonMartAdapter#setMoney` confirms a successful purchase.
- KIF's own single bonus for buying 10 or more (a Premier Ball, DNA Reverser,
  or DNA Splicers) is held back when a per-10 reward applies to that purchase,
  so nothing is given twice. Its message is hidden when KR's reward was added.

When `Regular Mart` is Standard, KR delegates the complete Mart call to KIF's
original implementation. Reloaded mode uses KR-owned buy and sell loops while
retaining `PokemonMartAdapter` as the inventory, price, and payment authority.
