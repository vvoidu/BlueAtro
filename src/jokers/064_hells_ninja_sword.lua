SMODS.Joker({
	key = "hells_ninja_sword",
	atlas = "blueatro_joker_atlas",
	pos = BlueAtro.id_to_atlas_pos(64),
	config = { extra = {} },
	rarity = 1,
	cost = 5,
	blueprint_compat = true,
	eternal_compat = true,
	perishable_compat = true,
	loc_vars = function(_, info_queue, card) end,
	calculate = function(self, card, context)
		if context.joker_main then
			return {
				chips = G.GAME.hands["Three of a Kind"].chips,
				mult = G.GAME.hands["Three of a Kind"].mult,
				card = context.blueprint_card or card,
			}
		end
	end,
	joker_display_def = function(JokerDisplay)
		return {
			text = {
				{ text = "+", colour = G.C.CHIPS },
				{ ref_table = "card.joker_display_values", ref_value = "chips", colour = G.C.CHIPS },
				{ text = " +", colour = G.C.MULT },
				{ ref_table = "card.joker_display_values", ref_value = "mult", colour = G.C.MULT },
			},
			calc_function = function(card)
				card.joker_display_values.chips = G.GAME.hands["Three of a Kind"].chips
				card.joker_display_values.mult = G.GAME.hands["Three of a Kind"].mult
			end,
		}
	end,
})
