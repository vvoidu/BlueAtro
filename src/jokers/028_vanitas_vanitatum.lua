SMODS.Joker({
	key = "vanivani",
	atlas = "blueatro_joker_atlas",
	pos = BlueAtro.id_to_atlas_pos(28),
	config = { extra = { xmult = 4 } },
	rarity = 3,
	cost = 8,
	blueprint_compat = true,
	eternal_compat = true,
	perishable_compat = true,
	loc_vars = function(self, info_queue, card)
		return { vars = { card.ability.extra.xmult } }
	end,
	calculate = function(self, card, context)
		if context.joker_main then
			if G.hand.cards == nil or #G.hand.cards == 0 then
				return true
			end
			local poker_hand, _, _, _, _ = G.FUNCS.get_poker_hand_info(G.hand.cards)

			if poker_hand == "High Card" then
				return {
					x_mult = card.ability.extra.xmult,
					card = context.blueprint_card or card,
					colour = G.C.MULT,
				}
			end
		end
	end,
	joker_display_def = function(JokerDisplay)
		return {
			text = {
				{ text = "X", colour = G.C.MULT },
				{ ref_table = "card.joker_display_values", ref_value = "xmult", colour = G.C.MULT },
			},
			calc_function = function(card)
				local unhighlighted = {}
				for _, held in ipairs(G.hand.cards) do
					if not held.highlighted then
						unhighlighted[#unhighlighted + 1] = held
					end
				end

				if #unhighlighted == 0 then
					card.joker_display_values.xmult = card.ability.extra.xmult
				else
					local text, poker_hand, scoring_hand = JokerDisplay.evaluate_hand(unhighlighted)
					if text == "Unknown" then
						card.joker_display_values.xmult = "?"
					else
						card.joker_display_values.xmult = card.ability.extra.xmult
					end
				end
			end,
		}
	end,
})
