# Kanto Reloaded Legacy Save Data

Kanto Reloaded Legacy registers one `:kanto_reloaded` entry with KIF's
`SaveData` system. Framework services, built-in modules, and external mods
receive separate namespaces inside that bucket.

```ruby
KantoReloaded::SaveData.system(:framework_service)
KantoReloaded::SaveData.module_data(:module_id)
KantoReloaded::SaveData.mod(:external_mod_id)

KantoReloaded::SaveData.get(:module_id, :key, nil, :section => :modules)
KantoReloaded::SaveData.set(:module_id, :key, value, :section => :modules)
```

Only values accepted by `Marshal.dump` can be stored. If a save was created by
a newer KR schema, or a migration fails, KR preserves the original bucket and
blocks KR bucket writes for that session.

`KantoReloaded::SaveProtection` tracks the source slot through a guarded wrapper
around `SaveData.read_from_file`. Before a KR schema migration, it copies the
source save and size-verifies the copy. The backup is named the way KIF names
its own, `backups/<slot>/<slot>_<yyyymmddhhmmss>_Before KR Legacy Update.rxdata`
beside the source save, so the game's `Load an older backup` list shows it.

The trim only touches Legacy's own backups in that folder: Ones with this name,
and the `<slot>_<yyyymmdd-hhmmss>[_n].rxdata` backups older Kanto Reloaded
versions made. It keeps the newest `Settings::SAVEFILE_NB_BACKUPS` of them (10
when the game doesn't set it); KIF's backups and the player's named ones are
never deleted. It does not replace KIF's normal save writer or backup behavior.

## Migrations

Increase `KantoReloaded::SaveData::SCHEMA_VERSION` only when existing bucket
data must change shape. Every migration advances exactly one schema version.

```ruby
KantoReloaded::SaveMigrations.register(
  :schema_1_to_2,
  :from => 1,
  :to => 2
) do |bucket|
  bucket[:modules][:new_id] = bucket[:modules].delete(:old_id) || {}
  bucket
end
```

Adding an optional key with a runtime default does not require a schema change.
