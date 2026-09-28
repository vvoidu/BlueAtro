-- Cards in `played` that are not in `scoring`.
local unscored_cards = function(played, scoring)
	local scoring_set = {}
	for _, c in ipairs(scoring or {}) do
		scoring_set[c] = true
	end
	local ret = {}
	for _, c in ipairs(played or {}) do
		if not scoring_set[c] then
			ret[#ret + 1] = c
		end
	end
	return ret
end

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
			local cards = unscored_cards(context.full_hand, context.scoring_hand)
			for _, held in ipairs(G.hand.cards or {}) do
				cards[#cards + 1] = held
			end

			local poker_hand = "NULL"
			if #cards > 0 then
				poker_hand = G.FUNCS.get_poker_hand_info(cards)
			end

			if poker_hand == "High Card" or poker_hand == "NULL" then
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
				local _, _, scoring_hand = JokerDisplay.evaluate_hand()
				local cards = unscored_cards(G.hand.highlighted, scoring_hand)
				for _, held in ipairs(G.hand.cards) do
					if not held.highlighted then
						cards[#cards + 1] = held
					end
				end

				if #cards == 0 then
					card.joker_display_values.xmult = card.ability.extra.xmult
				else
					local text = JokerDisplay.evaluate_hand(cards)
					if text == "Unknown" then
						card.joker_display_values.xmult = "?"
					elseif text == "High Card" or text == "NULL" then
						card.joker_display_values.xmult = card.ability.extra.xmult
					else
						card.joker_display_values.xmult = 1
					end
				end
			end,
		}
	end,
})
