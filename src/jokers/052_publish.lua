SMODS.Joker({
	key = "publish",
	atlas = "blueatro_joker_atlas",
	pos = BlueAtro.id_to_atlas_pos(52),
	config = { extra = { h_size = 4, cost = 3 } },
	rarity = 2,
	cost = 5,
	blueprint_compat = false,
	eternal_compat = true,
	perishable_compat = true,
	loc_vars = function(_, info_queue, card)
		return {
			vars = {
				card.ability.extra.h_size,
				card.ability.extra.cost,
			},
		}
	end,
	add_to_deck = function(self, card, from_debuff)
		G.hand:change_size(card.ability.extra.h_size)
	end,
	remove_from_deck = function(self, card, from_debuff)
		G.hand:change_size(-card.ability.extra.h_size)
	end,
	calc_dollar_bonus = function(self, card)
		return -card.ability.extra.cost
	end,
	joker_display_def = function(JokerDisplay)
		return {
			text = {
				{ text = "-$", colour = G.C.MONEY },
				{ ref_table = "card.ability.extra", ref_value = "cost", colour = G.C.MONEY },
			},
		}
	end,
})
