# Kanto Reloaded Legacy Hooks

`KantoReloaded::Hooks.wrap` is the standard way for KR and KR modules to wrap
base instance, global, and singleton methods. It is an alias-based helper, not
a conflict tracker or method replacement registry.

## Instance Methods

```ruby
KantoReloaded::Hooks.wrap(PokemonOption_Scene, :pbUpdate, :my_module_update) do |hook, *args|
  result = hook.call
  MyModule.after_update(self)
  result
end
```

The block runs with the original receiver as `self`. `hook.call` forwards the
original arguments and original block. Its return value is the original method
result. The wrapper block's final value becomes the wrapped method's result.

## Singleton Methods

```ruby
KantoReloaded::Hooks.wrap(GameData, :load_all, :my_module_load, :singleton => true) do |hook, *args|
  result = hook.call
  MyModule.refresh
  result
end
```

## Forwarding Changes

- `hook.call` calls the original method with its original arguments and block.
- `hook.call(new_args...)` replaces the arguments but keeps the original block.
- `hook.call_with(array, block)` explicitly supplies both.
- `hook.call_without_block` forwards the original arguments without the block.
- `hook.receiver`, `hook.arguments`, `hook.block`, and `hook.block_given?` expose
  the original invocation when a wrapper needs to inspect it.

## Guarantees

- Installation is idempotent for the same target, method, and hook ID.
- An inherited alias does not incorrectly mark a subclass as wrapped.
- Public, protected, and private visibility is preserved.
- Instance and singleton methods use the same API.
- Arguments and blocks are forwarded unchanged by `hook.call`.
- Return values are not rewritten by the helper.
- Runtime exceptions from the original method or wrapper are not swallowed.

Use a stable, module-owned hook ID. Do not manually alias base methods in a KR
module when this API can express the wrapper.

## Missing Targets

If the target method isn't in the game (or the target is `nil`), `wrap`
installs nothing and returns `false`. The miss is logged once per target and
hook ID as a warning on the `hooks` channel of Legacy's log
(`Mods/KantoReloadedLegacy/Logging/Log.txt`):

```text
Hook skipped: PokemonOption_Scene#pbUpdate isn't in this game (my_module_update)
```

On KIF a skipped hook usually means a feature that quietly does nothing, so a
run's log lists every one of them. Modules that check `defined?(SomeClass)`
before wrapping skip a missing class without a log line. With
`:required => true` the miss is logged as a failed install instead (an error
naming the missing target), and `wrap` still returns `false`.

## Late Reattachment

If a later script replaces a method outright, the same hook can explicitly
capture that new implementation in another alias generation:

```ruby
KantoReloaded::Hooks.wrap(
  TargetClass,
  :method_name,
  :my_module_hook,
  :reattach => true
) do |hook, *args|
  hook.call
end
```

`KantoReloaded::Hooks.outermost?` reports whether the recorded KR wrapper is
still the outermost implementation. A correctly aliased wrapper from another
mod can make this return `false` while still retaining KR in its original-call
chain, so reattachment is deliberately explicit rather than automatic.
