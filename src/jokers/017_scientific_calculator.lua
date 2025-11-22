SMODS.Joker({
	key = "calculator",
	atlas = "blueatro_joker_atlas",
	pos = BlueAtro.id_to_atlas_pos(17),
	config = { extra = { chips = 100 } },
	rarity = 2,
	cost = 7,
	blueprint_compat = true,
	eternal_compat = true,
	perishable_compat = true,
	loc_vars = function(_, info_queue, card)
		return { vars = { card.ability.extra.chips } }
	end,
	calculate = function(_, card, context)
		if context.individual and context.cardarea == G.hand and not context.end_of_round then
			if next(SMODS.get_enhancements(context.other_card)) then
				if context.other_card.debuff then
					return {
						message = localize("k_debuffed"),
						colour = G.C.RED,
						card = context.other_card,
					}
				else
					return {
						h_chips = card.ability.extra.chips,
					}
				end
			end
		end
	end,
	joker_display_def = function(JokerDisplay)
		return {
			text = {
				{ text = "+", colour = G.C.CHIPS },
				{ ref_table = "card.joker_display_values", ref_value = "chips", colour = G.C.CHIPS },
			},
			calc_function = function(card)
				local chips = 0
				for _, playing_card in ipairs(G.hand.cards) do
					if
						not playing_card.highlighted
						and next(SMODS.get_enhancements(playing_card))
						and not (playing_card.facing == "back")
						and not playing_card.debuff
					then
						chips = chips
							+ card.ability.extra.chips
								* JokerDisplay.calculate_card_triggers(playing_card, G.hand.highlighted)
					end
				end
				card.joker_display_values.chips = chips
			end,
		}
	end,
})
