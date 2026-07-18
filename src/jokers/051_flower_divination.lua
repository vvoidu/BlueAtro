SMODS.Joker({
	key = "flower_divination",
	atlas = "blueatro_joker_atlas",
	pos = BlueAtro.id_to_atlas_pos(51),
	config = { extra = { mult = 1 } },
	rarity = 3,
	cost = 7,
	blueprint_compat = true,
	eternal_compat = true,
	perishable_compat = false,
	enhancement_gate = "m_mult",
	loc_vars = function(_, info_queue, card)
		return { vars = { (card.ability.extra.mult_multiplier - 1) * 100, card.ability.extra.mult } }
	end,
	calculate = function(_, card, context)
		if context.joker_main then
			return {
				mult = card.ability.extra.mult,
			}
		elseif
			context.individual
			and context.cardarea == G.play
			and not context.end_of_round
			and not SMODS.has_no_rank(context.other_card)
			and not context.other_card.debuff
			and not context.blueprint
			and SMODS.has_enhancement(context.other_card, "m_mult")
		then
			SMODS.scale_card(card, {
				ref_table = card.ability.extra,
				ref_value = "mult",
				scalar_value = "mult_multiplier",
				message_colour = G.C.MULT,
				operation = function(ref_table, ref_value, initial, change)
					ref_table[ref_value] = initial * change
				end,
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
