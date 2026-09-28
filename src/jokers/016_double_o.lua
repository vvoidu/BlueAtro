SMODS.Joker({
	key = "double_o",
	atlas = "blueatro_joker_atlas",
	pos = BlueAtro.id_to_atlas_pos(16),
	config = { extra = { xmult = 1, xmult_gain = 0.5 } },
	rarity = 3,
	cost = 9,
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
		elseif context.pre_discard and not context.blueprint then
			local _, _, poker_hands = G.FUNCS.get_poker_hand_info(context.full_hand)
			if not next(poker_hands["Pair"]) then
				return
			end
			SMODS.scale_card(card, {
				ref_table = card.ability.extra,
				ref_value = "xmult",
				scalar_value = "xmult_gain",
				message_colour = G.C.MULT,
			})
			return
		elseif context.ante_change and context.ante_end and context.main_eval and not context.blueprint then
			card.ability.extra.xmult = self.config.extra.xmult
			return {
				message = localize("k_reset"),
				colour = G.C.MULT,
			}
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
