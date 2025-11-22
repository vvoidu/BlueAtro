SMODS.Joker({
	key = "dango",
	atlas = "blueatro_joker_atlas",
	pos = BlueAtro.id_to_atlas_pos(9),
	config = { extra = { mult = 15 } },
	rarity = 1,
	cost = 6,
	blueprint_compat = true,
	eternal_compat = false,
	perishable_compat = true,
	loc_vars = function(_, info_queue, card)
		return { vars = { card.ability.extra.mult } }
	end,
	calculate = function(_, card, context)
		if G.GAME.current_round.discards_left == 0 then
			SMODS.destroy_cards(card)
			return
		end

		if context.joker_main then
			return {
				mult = card.ability.extra.mult,
				colour = G.C.MULT,
				card = context.blueprint_card or card,
			}
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
