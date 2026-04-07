SMODS.Joker({
	key = "photocard",
	atlas = "blueatro_joker_atlas",
	pos = BlueAtro.id_to_atlas_pos(15),
	config = { extra = { mult_gain = 1 } },
	rarity = 2,
	cost = 6,
	blueprint_compat = true,
	eternal_compat = true,
	perishable_compat = true,
	loc_vars = function(_, info_queue, card)
		return { vars = { card.ability.extra.mult_gain } }
	end,
	calculate = function(_, card, context)
		if context.individual and context.cardarea == G.play then
			if context.other_card:get_id() == 12 then
				SMODS.scale_card(context.other_card, {
					ref_table = context.other_card.ability,
					ref_value = "perma_mult",
					scalar_table = card.ability.extra,
					scalar_value = "mult_gain",
					message_colour = G.C.MULT,
				})
				return
			end
		end
	end,
})
