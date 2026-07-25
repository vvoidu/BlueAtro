SMODS.Joker({
	key = "romantic_finale",
	atlas = "blueatro_joker_atlas",
	pos = BlueAtro.id_to_atlas_pos(59),
	config = { extra = { cards = 15, xmult = 15.2 } },
	rarity = 3,
	cost = 9,
	blueprint_compat = true,
	eternal_compat = true,
	perishable_compat = true,
	loc_vars = function(self, info_queue, card)
		return { vars = { card.ability.extra.cards, card.ability.extra.xmult } }
	end,
	calculate = function(self, card, context)
		if
			context.individual
			and context.cardarea == G.play
			and #G.deck.cards == card.ability.extra.cards
			and next(context.poker_hands["Straight"])
		then
			return {
				xmult = card.ability.extra.xmult,
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
				local _, poker_hands, scoring_hand = JokerDisplay.evaluate_hand()
				if
					#G.deck.cards == card.ability.extra.cards
					and poker_hands["Straight"]
					and next(poker_hands["Straight"])
				then
					card.joker_display_values.xmult = card.ability.extra.xmult
				else
					card.joker_display_values.xmult = 1.0
				end
			end,
		}
	end,
})
