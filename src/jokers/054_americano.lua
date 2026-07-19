SMODS.Joker({
	key = "americano",
	atlas = "blueatro_joker_atlas",
	pos = BlueAtro.id_to_atlas_pos(54),
	config = { extra = { xmult = 1.5, xmult_loss = 0.01 } },
	rarity = 2,
	cost = 6,
	blueprint_compat = true,
	eternal_compat = true,
	perishable_compat = true,
	loc_vars = function(_, info_queue, card)
		return {
			vars = {
				card.ability.extra.xmult,
				card.ability.extra.xmult_loss,
			},
		}
	end,
	calculate = function(_, card, context)
		if context.individual and context.cardarea == G.play and context.other_card:is_suit("Diamonds") then
			---@diagnostic disable-next-line: param-type-mismatch
			SMODS.calculate_effect({ xmult = card.ability.extra.xmult }, context.other_card)

			if not context.blueprint then
				card.ability.extra.xmult = card.ability.extra.xmult - card.ability.extra.xmult_loss
				if card.ability.extra.xmult <= 1 then
					SMODS.destroy_cards(card, { bypass_eternal = true })
					return {
						message = localize("k_eaten_ex"),
						colour = G.C.FILTER,
						focus = card,
					}
				else
					return {
						message = localize({
							type = "variable",
							key = "a_xmult_minus",
							vars = { card.ability.extra.xmult_loss },
						}),
						colour = G.C.RED,
						delay = 0.2,
						focus = card,
					}
				end
			end
		end
	end,
	joker_display_def = function(JokerDisplay)
		return {
			text = {
				{
					border_nodes = {
						{ text = "X" },
						{ ref_table = "card.joker_display_values", ref_value = "xmult", retrigger_type = "exp" },
					},
				},
			},
			calc_function = function(card)
				local total_xmult = 1
				local text, _, scoring_hand = JokerDisplay.evaluate_hand()
				local xmult = card.ability.extra.xmult

				if text ~= "Unknown" then
					for _, c in ipairs(scoring_hand) do
						if c:is_suit("Diamonds") and c.facing == "front" then
							local count = JokerDisplay.calculate_card_triggers(c)
							for i = 1, count do
								total_xmult = total_xmult * xmult
								xmult = math.max(1.0, xmult - card.ability.extra.xmult_loss)
							end
						end
					end
				end
				card.joker_display_values.xmult = total_xmult
			end,
		}
	end,
})
