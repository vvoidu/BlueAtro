SMODS.Joker({
	key = "germanium_bracelet",
	atlas = "blueatro_joker_atlas",
	pos = BlueAtro.id_to_atlas_pos(50),
	config = { extra = {} },
	rarity = 1,
	cost = 4,
	blueprint_compat = true,
	eternal_compat = true,
	perishable_compat = true,
	loc_vars = function(_, info_queue, card)
		return { vars = {} }
	end,
	calculate = function(_, card, context)
		if
			context.individual
			and not context.end_of_round
			and not SMODS.has_no_rank(context.other_card)
			and not context.other_card.debuff
		then
			if context.cardarea == G.play then
				return {
					mult = context.other_card:get_id(),
				}
			elseif context.cardarea == G.hand then
				return {
					mult = -context.other_card:get_id(),
				}
			end
		end
	end,
	joker_display_def = function(JokerDisplay)
		return {
			text = {
				{ ref_table = "card.joker_display_values", ref_value = "mult", colour = G.C.MULT },
			},
			calc_function = function(card)
				local mult = 0
				local _, _, scoring_hand = JokerDisplay.evaluate_hand()
				for i = 1, #scoring_hand do
					local c = scoring_hand[i]
					if not SMODS.has_no_rank(c) then
						mult = mult + JokerDisplay.calculate_card_triggers(c) * c:get_id()
					end
				end

				for i = 1, #G.hand.cards do
					local c = G.hand.cards[i]
					if not SMODS.has_no_rank(c) then
						if not c.highlighted then
							-- Held in hand
							mult = mult - JokerDisplay.calculate_card_triggers(c, true) * c:get_id()
						end
					end
				end

				-- Need to add our own plus sign if positive
				card.joker_display_values.mult = (mult < 0 and "" or "+") .. mult
			end,
		}
	end,
})
