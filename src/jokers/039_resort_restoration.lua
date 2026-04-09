SMODS.Joker({
	key = "resort_restoration",
	atlas = "blueatro_joker_atlas",
	pos = BlueAtro.id_to_atlas_pos(39),
	config = { extra = { dollar_gain = 0, dollar_growth = 1 } },
	rarity = 1,
	cost = 6,
	blueprint_compat = false,
	eternal_compat = true,
	perishable_compat = true,
	loc_vars = function(_, info_queue, card)
		return {
			vars = {
				card.ability.extra.dollar_gain,
				card.ability.extra.dollar_growth,
			},
		}
	end,
	calculate = function(self, card, context)
		if context.before and not context.blueprint and next(context.poker_hands["Full House"]) then
			SMODS.scale_card(card, {
				ref_table = card.ability.extra,
				ref_value = "dollar_gain",
				scalar_value = "dollar_growth",
			})
			return
		end
	end,
	calc_dollar_bonus = function(self, card)
		return card.ability.extra.dollar_gain
	end,
	joker_display_def = function(JokerDisplay)
		return {
			text = {
				{ text = "+$", colour = G.C.MONEY },
				{ ref_table = "card.ability.extra", ref_value = "dollar_gain", colour = G.C.MONEY },
			},
		}
	end,
})
