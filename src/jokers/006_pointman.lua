local is_leftmost = function(card)
	return G.jokers and G.jokers.cards and G.jokers.cards[1] == card
end

SMODS.Joker({
	key = "pointman",
	atlas = "blueatro_joker_atlas",
	pos = BlueAtro.id_to_atlas_pos(6),
	config = { extra = { xmult = 2 } },
	rarity = 2,
	cost = 6,
	blueprint_compat = true,
	eternal_compat = true,
	perishable_compat = true,
	loc_vars = function(_, info_queue, card)
		return {
			vars = { card.ability.extra.xmult },
		}
	end,
	calculate = function(_, card, context)
		if context.joker_main and is_leftmost(card) then
			return {
				x_mult = card.ability.extra.xmult,
				card = context.blueprint_card or card,
				colour = G.C.MULT,
			}
		end
	end,
	joker_display_def = function(JokerDisplay)
		return {
			text = {
				{ text = "X", colour = G.C.MULT },
				{ ref_table = "card.joker_display_values", ref_value = "xmult", colour = G.C.MULT },
			},
			calc_function = function(card)
				card.joker_display_values.xmult = is_leftmost(card) and card.ability.extra.xmult or 1
			end,
		}
	end,
})
