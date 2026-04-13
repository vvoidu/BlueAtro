SMODS.Joker({
	key = "flower_divination",
	atlas = "blueatro_joker_atlas",
	pos = BlueAtro.id_to_atlas_pos(50),
	config = { extra = { mult = 0, mult_gain = 4 } },
	rarity = 2,
	cost = 7,
	blueprint_compat = true,
	eternal_compat = true,
	perishable_compat = false,
	enhancement_gate = "m_mult",
	loc_vars = function(_, info_queue, card)
		return { vars = { card.ability.extra.mult_gain, card.ability.extra.mult } }
	end,
	calculate = function(_, card, context)
		if context.joker_main then
			return {
				mult = card.ability.extra.mult,
			}
		elseif
			context.individual
			and not context.end_of_round
			and not SMODS.has_no_rank(context.other_card)
			and not context.other_card.debuff
			and not context.blueprint
			and SMODS.has_enhancement(context.other_card, "m_mult")
		then
			SMODS.scale_card(card, {
				ref_table = card.ability.extra,
				ref_value = "mult",
				scalar_value = "mult_gain",
				message_colour = G.C.MULT,
			})
			return
		end
	end,
	joker_display_def = function(JokerDisplay)
		return {
			text = {
				{ text = "+", colour = G.C.MULT },
				{ ref_table = "card.ability.extra", ref_value = "mult", colour = G.C.MULT },
			},
		}
	end,
})
