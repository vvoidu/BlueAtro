SMODS.Joker({
	key = "teabagging",
	atlas = "blueatro_joker_atlas",
	pos = BlueAtro.id_to_atlas_pos(1),
	config = { extra = { mult = 0, mult_gain = 3 } },
	rarity = 1,
	cost = 4,
	blueprint_compat = true,
	eternal_compat = true,
	perishable_compat = false,
	loc_vars = function(_, info_queue, card)
		return { vars = { card.ability.extra.mult, card.ability.extra.mult_gain } }
	end,
	calculate = function(_, card, context)
		if context.joker_main and card.ability.extra.mult > 0 then
			return {
				mult = card.ability.extra.mult,
				card = context.blueprint_card or card,
				colour = G.C.MULT,
			}
		elseif context.remove_playing_cards and not context.blueprint and context.main_eval then
			if not context.removed or #context.removed == 0 then
				return
			end
			for i = 1, #context.removed do
				SMODS.calculate_effect({
					message = localize({
						type = "variable",
						key = "a_mult",
						vars = { card.ability.extra.mult },
					}),
				}, card)
			end
		elseif
			context.joker_type_destroyed
			and not context.blueprint
			and context.card.area == G.jokers
			and card ~= context.card
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
