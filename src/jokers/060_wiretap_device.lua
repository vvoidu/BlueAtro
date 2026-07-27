SMODS.Joker({
	key = "wiretap_device",
	atlas = "blueatro_joker_atlas",
	pos = BlueAtro.id_to_atlas_pos(60),
	config = { extra = { odds = 4 } },
	rarity = 1,
	cost = 5,
	blueprint_compat = true,
	eternal_compat = true,
	perishable_compat = true,
	loc_vars = function(_, info_queue, card)
		local num, denom = SMODS.get_probability_vars(card, 1, card.ability.extra.odds)
		return { vars = { num, denom } }
	end,
	calculate = function(_, card, context)
		if context.end_of_round and context.main_eval and not context.game_over then
			if SMODS.pseudorandom_probability(card, card.config.center.key, 1, card.ability.extra.odds) then
				local target = pseudorandom_element(G.jokers.cards, pseudoseed(card.config.center.key))
				if target then
					target:set_edition("e_foil")
					return {
						message = localize("k_upgrade_ex"),
						colour = G.C.EDITION,
					}
				end
			end
		end
	end,
	joker_display_def = function(JokerDisplay)
		return {
			text = {
				{ text = "(" },
				{ ref_table = "card.joker_display_values", ref_value = "odds" },
				{ text = ")" },
			},
			text_config = { colour = G.C.GREEN },
			calc_function = function(card)
				local num, denom = SMODS.get_probability_vars(card, 1, card.ability.extra.odds)
				card.joker_display_values.odds = localize({
					type = "variable",
					key = "jdis_odds",
					vars = { num, denom },
				})
			end,
		}
	end,
})
