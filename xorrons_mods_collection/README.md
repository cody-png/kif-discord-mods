# Xorron's Mods Collection

By Xorron. Imported from the KIF Discord for KIF's Discord Mods catalog. This page describes version 1.1.1.

## What it does

Several small mods in one pack, with one settings page. The feature descriptions are based on the author's notes.

- **Follower System:** up to 6 party Pokémon walk with you on the map. With 3 or more, they walk in a V formation around you.
- **Wandering Trainers:** trainers walk around larger maps, each with a Pokémon at their side. Talk to one to battle them, alone or as a group of 2 or 3.
- **Xorrons Map Progress:** win battles on a map and the wild Pokémon there get stronger. Lose and they get weaker again.
- **Auto-Capture:** with KIF's Auto-Battle on, Auto-Battle throws a ball at wild Pokémon you have not caught yet.
- **100% Catch Rate:** a ball always catches a species you have not caught yet.
- **Catch Multi-Wild:** meant to let you throw balls when 2 or more wild Pokémon are out. KIF already allows that, so it changes nothing.
- **Infinite Safari:** no step limit in the Safari Zone.
- **Graphic Overhaul (FPS):** draws the overworld at 60 or 90 frames a second.
- **Shiny sprites:** shiny followers, and shiny Pokémon walking with wandering trainers, show their shiny colours on the map.

## Installing

- Options > Mods > Browse > Discord Mods > Xorron's Mods Collection.
- It starts working the next time the game starts.
- If Mods is greyed out, set Options > KIF Settings > Modules > Mod Settings to On first.
- Most parts are On right after installing: Wandering Trainers, Xorrons Map Progress, Infinite Safari, Auto-Capture, Catch Multi-Wild and 100% Catch Rate. The Follower System starts Off. Turn off what you don't want (see Settings).

## How to use it

### Followers

- Set Follower System to On. Your party Pokémon appear behind you in party order, up to Follower Limit. Fainted Pokémon don't follow.
- With 3 or more followers and Follower Formation (V-Shape) On, each party slot has its own spot: slot 1 walks behind you, slots 2 and 3 on either side of you, slots 4 and 5 behind those two, and slot 6 two steps behind you.
- If a follower's spot is blocked, that follower trails behind instead. With Follower Formation (V-Shape) Off, they all walk in a line.
- In the V formation, the follower from slot 1 faces you. The others face the way you walk.
- They update by themselves when your party changes: a swap, a heal, a faint or an evolution.
- Stand still for a while and they start to wander around. They come back when you walk.
- Talk to a follower: its cry plays, then you get Pet, Recall to Ball or Cancel. Pet makes it hop. Recall to Ball sends it back and sets its slot to Off.
- Fused followers: with Follower Shapeshift On, they switch between the head and the body Pokémon's sprite now and then, with a sound, a hop and a flash. Shapeshift Speed sets how often.
- Each party slot has a mode: Body, Head, Auto or Off. Body and Head set which half of a fusion it looks like first; Auto starts as Body. Off means that slot doesn't follow.
- Pokémon with no walking sprite of their own borrow another Pokémon's sprite, always the same one for that species. It is recoloured when the Pokémon is shiny.

### Wandering Trainers

- Up to Wandering Trainer Limit trainers (10 by default) appear on a map and walk around, each with a Pokémon at their side. They never appear right next to you.
- Maps under 28 tiles wide and under 28 tiles high get none. Neither do maps whose name has a word like Center, Mart, Gym, Lab, House, Room, Gate, Hotel, Office or Floor.
- When you come within 3 steps, a trainer notices you with an animation and a sound.
- Talk to the trainer or their Pokémon. Their name shows, with SHINY DETECTED under it when their team has a shiny. You get:
  - **Challenge Trainer:** a normal trainer battle.
  - **Scan Team Stats:** their team on the Summary screen.
  - **Cancel.**
- If 1 or 2 more wandering trainers stand within 3 steps of the one you talk to, they join the battle: their teams become one opposing team in a double or triple battle. The first choice then reads Challenge Duo (2 vs 2) or Challenge Trio (3 vs 3), when you have that many Pokémon.
- Teams are random Pokémon. About half are fusions, legendary Pokémon can show up, and each has a 1 in 10 chance to be shiny.
- Most trainers have 1 to 4 Pokémon, up to 5 levels under your party's average. Gym Leaders, Red, Leaf and Rival Gary have 4 to 6, up to 5 levels above it.
- Beat them and they say a parting line and leave. New trainers keep appearing while you stay on the map, up to the limit.
- When you arrive on another map that allows them, it gets a new set.

### Xorrons Map Progress

- Every map keeps its own count. Win 5 battles on a map and its wild Pokémon become 1 level higher. Each further 5 wins adds another level. A message tells you the new bonus.
- Catching a Pokémon counts as a win. Trainer battles on the map count too.
- A battle counts as a loss if you lose it, or if one of your Pokémon is fainted at the end that wasn't at the start. A loss lowers that map's bonus by 1 and starts the count of 5 again.
- Running away counts as neither a win nor a loss, unless one of your Pokémon fainted.
- Wild Pokémon never go above level 100.

### Auto-Capture

- Turn on Auto-Battle: Options > KIF Settings > Battles > Auto-Battle.
- In wild battles, when Auto-Battle chooses for your first Pokémon, it throws a ball at, in this order:
  - a shiny of a species you have not caught,
  - a shiny of a species you already have, only with Catch All Shinies On,
  - any species you have not caught.
- It throws the best ball you carry: Master Ball, then Ultra Ball, Great Ball, Poke Ball, then any other ball. Thrown balls are used up as normal.
- With no target or no ball, Auto-Battle fights as usual.
- If Auto-Battle's Stop on Shiny is On, Auto-Battle switches itself off when a shiny appears, so you throw the ball yourself.

### 100% Catch Rate

- Any ball you throw at a wild species you have not caught yet catches it, as a critical capture. Where the game blocks catching, such as in trainer battles, it stays blocked.
- With Catch All Shinies On, shinies of species you already have are caught the same way.
- It works with or without Auto-Battle.

### Catch Multi-Wild

- It was made to let you throw balls in wild battles with 2 or more wild Pokémon.
- KIF already lets you do that, so this setting changes nothing you would notice.

### Infinite Safari

- No step limit in the Safari Zone.
- If you switch it off while in the Safari Zone, you get the normal number of steps.

### Graphic Overhaul (FPS)

- 60 FPS or 90 FPS: the overworld is drawn at that rate, so walking and scrolling look smoother. The game itself runs at its normal speed.
- It does the same thing as KIF's own Frame rate setting (Options > KIF Settings > System > Frame rate), and takes its place while on.
- Off: KIF's Frame rate setting is used again.

## Settings

- Options > KIF Settings > Mods, then Xorron's Mods Collection settings. The same rows are also under Settings by category.
- Most changes apply at once (see Limits for the ones that don't). They count for every save file.
- The first row, Xorron Mod Menu, opens the author's own menu with the same settings in one list. Pick an entry to switch it or step to its next value. It also has Configure Follower Modes: pick a party slot to step its mode through Body, Head, Auto and Off.

The settings, with their defaults:

- **Xorrons Map Progress:** Off or On. Default On.
- **Wandering Trainers:** Off or On. Default On.
- **Wandering Trainer Limit:** 1 to 10. Default 10. How many wandering trainers a map can have.
- **Infinite Safari:** Off or On. Default On.
- **Graphic Overhaul (FPS):** Off, 60 FPS or 90 FPS. Default Off.
- **Follower System:** Off or On. Default Off.
- **Follower Formation (V-Shape):** Off or On. Default On.
- **Follower Limit:** 1 to 6. Default 6. Counts party slots from the first one.
- **Follower Shapeshift:** Off or On. Default On.
- **Shapeshift Speed:** Fast, Normal, Slow or Very Slow. Default Normal. Each step waits about twice as long as the one before.
- **Follower Idle Anim:** Off or On. Default On. Followers keep stepping in place while they stand.
- **Auto Refresh Slots:** Off or On. Default On. It has no effect (see Limits).
- **Auto-Capture:** Off or On. Default On.
- **Catch All Shinies:** Off or On. Default Off.
- **Catch Multi-Wild:** Off or On. Default On. It has no effect in KIF (see Catch Multi-Wild).
- **100% Catch Rate:** Off or On. Default On.
- **Follower Slot 1 Mode** to **Follower Slot 6 Mode:** Body, Head, Auto or Off. Default Body.

## Changes for KIF

- The settings are on KIF's Mods settings page, one row each, and the author's menu opens from there.
- Saves stay loadable with or without the mod. Wandering trainers and followers are left out of the save. After loading, your followers return and new trainers appear.
- A save made with the original version no longer crashes when its followers are drawn.
- Switching the Follower System off removes only this mod's followers, not the game's own companions.
- The original turned on the game's Debug mode for the whole game. This version does not.
- 60 FPS and 90 FPS no longer make the whole game run faster. They only make the overworld smoother. The original also changed how the game's own NPCs move; that part was removed.
- Shiny followers now show shiny colours. In the original nothing was recoloured.
- The Infinite Safari setting now works both ways. In the original the Safari Zone always had no step limit.
- Auto-Capture: in a double battle it throws one ball each turn, not one for each of your Pokémon.
- With Auto-Battle on, the opponent's move choices are no longer changed by the mod, items the opponent uses no longer come out of your Bag, and items that are not used up stay in your Bag.
- Wandering Doctors and Backpackers were removed, because battles with them crashed in this version of the game.

## Limits

- The Reset Xorrons Map Progress entry in the Xorron Mod Menu does not reset anything. It switches Xorrons Map Progress On or Off instead. There is no other way in the game to clear map progress.
- Map progress belongs to the game folder, not to a save file. All your saves share it, and a new game starts with it.
- Auto Refresh Slots changes nothing. Followers always update when your party changes.
- The Recall to Ball question reads "Recall {1}?" instead of showing the Pokémon's name.
- A recalled follower stays away, in every save, until you set its slot mode back.
- Changing Follower Idle Anim takes effect the next time you change maps, finish a battle or your party changes.
- Auto-Capture throws your Master Ball first if you carry one.
- Wandering trainers are not saved. After loading a save, new ones appear.
- Switching Wandering Trainers off does not remove the trainers already on the map right away. Lowering Wandering Trainer Limit does not remove them either.
- If you go into a map without wandering trainers, such as a house or a Pokémon Center, and come back out to the same map, the trainers you had not beaten are gone and no new ones take their place until you visit another map that has them.
- If your party is too small for a Duo or Trio, the choice still reads Challenge Trainer, but the nearby trainers join the battle anyway.
- In a Duo or Trio battle, the joined team is cut to its first 6 Pokémon.
- Catch Multi-Wild does nothing in KIF, which already lets you throw balls at 2 or more wild Pokémon.
