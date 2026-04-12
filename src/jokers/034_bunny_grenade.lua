SMODS.Joker({
	key = "bunny_grenade",
	atlas = "blueatro_joker_atlas",
	pos = BlueAtro.id_to_atlas_pos(34),
	config = { extra = { xmult = 1, xmult_gain = 0.1 } },
	rarity = 2,
	cost = 7,
	blueprint_compat = true,
	eternal_compat = true,
	perishable_compat = true,
	loc_vars = function(self, info_queue, card)
		return { vars = { card.ability.extra.xmult_gain, card.ability.extra.xmult } }
	end,
	calculate = function(self, card, context)
		if context.joker_main and card.ability.extra.xmult >= 1 then
			return {
				x_mult = card.ability.extra.xmult,
				card = context.blueprint_card or card,
				colour = G.C.MULT,
			}
		elseif context.first_hand_drawn and not context.blueprint and context.main_eval then
			local count = BlueAtro.count_filtered(G.hand.cards, function(c)
				return c:get_id() == 7
			end)
			card.ability.extra.xmult = card.ability.extra.xmult + card.ability.extra.xmult_gain * count
			SMODS.scale_card(card, {
				ref_table = card.ability.extra,
				ref_value = "xmult",
				scalar_value = "xmult_gain",
				operation = function(ref_table, ref_value, initial, change)
					ref_table[ref_value] = initial + count * change
				end,
				message_colour = G.C.MULT,
			})
			return
		end
	end,
	joker_display_def = function(JokerDisplay)
		return {
			text = {
				{ text = "X", colour = G.C.MULT },
				{ ref_table = "card.ability.extra", ref_value = "xmult", colour = G.C.MULT },
			},
		}
	end,
})
