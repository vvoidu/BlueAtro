-- Its effect cannot be implemented with `calculate`
-- because discarding during scoring doesn't work properly.
-- See lovely.toki.toml

SMODS.Sound({
	key = "e_pyon",
	path = "e_pyon.wav",
})
SMODS.Joker({
	key = "perfect_maid",
	atlas = "blueatro_joker_atlas",
	pos = BlueAtro.id_to_atlas_pos(41),
	config = { extra = { h_size = 2 } },
	rarity = 1,
	cost = 4,
	blueprint_compat = false,
	eternal_compat = true,
	perishable_compat = true,
	loc_vars = function(_, info_queue, card)
		return { vars = { card.ability.extra.h_size } }
	end,
	add_to_deck = function(self, card, from_debuff)
		G.hand:change_size(card.ability.extra.h_size)
	end,
	remove_from_deck = function(self, card, from_debuff)
		G.hand:change_size(-card.ability.extra.h_size)
	end,
})
