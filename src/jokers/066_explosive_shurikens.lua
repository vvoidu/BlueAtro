SMODS.Joker({
	key = "explosive_shurikens",
	atlas = "blueatro_joker_atlas",
	pos = BlueAtro.id_to_atlas_pos(66),
	config = { extra = { odds = 4, numerator = 1 } },
	rarity = 3,
	cost = 8,
	blueprint_compat = true,
	eternal_compat = true,
	perishable_compat = true,
	loc_vars = function(_, info_queue, card)
		local num, denom = SMODS.get_probability_vars(card, card.ability.extra.numerator, card.ability.extra.odds)
		return { vars = { num, denom } }
	end,
	calculate = function(self, card, context)
		if context.before and context.main_eval and not context.blueprint then
			if
				SMODS.pseudorandom_probability(
					card,
					card.config.center.key,
					card.ability.extra.numerator,
					card.ability.extra.odds
				)
			then
				SMODS.upgrade_poker_hands({ from = card, hands = { context.scoring_name } })
			end

			if context.scoring_name == "Three of a Kind" then
				if card.ability.extra.numerator < card.ability.extra.odds then
					card.ability.extra.numerator = card.ability.extra.numerator + 1
					return {
						message = localize("k_upgrade_ex"),
						colour = G.C.GREEN,
					}
				end
			elseif card.ability.extra.numerator ~= self.config.extra.numerator then
				card.ability.extra.numerator = self.config.extra.numerator
				return {
					message = localize("k_reset"),
					colour = G.C.GREEN,
				}
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
				local num, denom =
					SMODS.get_probability_vars(card, card.ability.extra.numerator, card.ability.extra.odds)
				card.joker_display_values.odds = localize({
					type = "variable",
					key = "jdis_odds",
					vars = { num, denom },
				})
			end,
		}
	end,
})
