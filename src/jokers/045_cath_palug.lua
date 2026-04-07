SMODS.Joker({
	key = "cath_palug",
	atlas = "blueatro_joker_atlas",
	pos = BlueAtro.id_to_atlas_pos(45),
	config = { extra = { odds = 3 } },
	rarity = 3,
	cost = 10,
	blueprint_compat = true,
	eternal_compat = true,
	perishable_compat = true,
	loc_vars = function(_, info_queue, card)
		local num, denom = SMODS.get_probability_vars(card, 1, card.ability.extra.odds)
		return { vars = { num, denom } }
	end,
	calculate = function(self, card, context)
		if context.before and context.main_eval then
			for _, playing_card in ipairs(G.play.cards) do
				if SMODS.has_enhancement(playing_card, "m_wild") and not playing_card.debuff then
					if SMODS.pseudorandom_probability(card, "kazusa", 1, card.ability.extra.odds) then
						card = context.blueprint or card
						SMODS.calculate_effect({
							message = localize("k_level_up_ex"),
						}, card)
						SMODS.smart_level_up_hand(playing_card, context.scoring_name, false)
					end
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
