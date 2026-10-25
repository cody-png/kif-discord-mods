#==============================================================================
# Kanto Reloaded Legacy - Reloaded PC: Hoenn's Transfer Box
#==============================================================================
# PIF's Hoenn games add a Transfer Box (StorageTransferBox) shared between
# saves of both games: each Pokemon put in or taken out saves the game, and
# the box refuses one that's already somewhere in this save. The game's own
# PC checks before anything moves (a rental can't go in, a duplicate is
# refused, the first move asks about the autosave) and shows the box's
# tutorial when it's opened. The Reloaded PC does the same (his call,
# 2026-10-22): every move asks here first, so a refused Pokemon is never
# taken from where it was.
#==============================================================================

module KantoReloaded
  module TransferBox
    module_function

    # The box at this index is the Transfer Box (the party is -1)
    def box?(storage, box)
      return false unless defined?(::StorageTransferBox) && box.is_a?(Integer) && box >= 0
      storage[box].is_a?(::StorageTransferBox)
    rescue StandardError
      false
    end

    # moves: [[pokemon, from box, to box], ...] (nil: held, not in a box).
    # True when every Pokemon may move, as the game's PC decides it.
    def allow?(storage, moves)
      involved = false
      moves.each do |pokemon, from, to|
        next unless pokemon
        if box?(storage, to)
          involved = true
          if (pokemon.owner.name == "RENTAL" rescue false)
            pbMessage(_INTL("This Pokémon cannot be transferred."))
            return false
          end
          return false if storage[to].check_is_duplicate(pokemon)
        end
        if box?(storage, from)
          involved = true
          return false if storage[from].check_is_duplicate(pokemon)
        end
      end
      return true unless involved
      defined?(verifyTransferBoxAutosave) ? verifyTransferBoxAutosave : true
    end

    # The box was opened: its tutorial once, then its shared Pokemon (or
    # disabled on a randomized save), as the game's PC does
    def entered(storage, box)
      return unless box?(storage, box)
      if defined?($PokemonGlobal) && $PokemonGlobal &&
         $PokemonGlobal.respond_to?(:seen_transfer_box_tutorial) &&
         !$PokemonGlobal.seen_transfer_box_tutorial
        transferBoxTutorial if defined?(transferBoxTutorial)
        $PokemonGlobal.seen_transfer_box_tutorial = true
      end
      if storage[box].can_use_transfer_box?
        storage[box].loadTransferBoxPokemon
      else
        storage[box].setDisabled
      end
    rescue StandardError => e
      KantoReloaded::Log.exception("Transfer Box check failed", e, :channel => :pc_organization) if defined?(KantoReloaded::Log)
    end
  end
end
