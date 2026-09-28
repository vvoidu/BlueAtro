SMODS.Joker({
	key = "romantic_finale",
	atlas = "blueatro_joker_atlas",
	pos = BlueAtro.id_to_atlas_pos(59),
	config = { extra = { cards = 15, xmult = 1, xmult_gain = 0.5 } },
	rarity = 3,
	cost = 9,
	blueprint_compat = true,
	eternal_compat = true,
	perishable_compat = true,
	loc_vars = function(self, info_queue, card)
		return { vars = { card.ability.extra.xmult_gain, card.ability.extra.xmult, card.ability.extra.cards } }
	end,
	calculate = function(self, card, context)
		if context.joker_main and card.ability.extra.xmult >= 1 then
			return {
				x_mult = card.ability.extra.xmult,
				card = context.blueprint_card or card,
				colour = G.C.MULT,
			}
		elseif
			context.before
			and not context.blueprint
			and #G.deck.cards % card.ability.extra.cards == 0
			and next(context.poker_hands["Straight"])
		then
			SMODS.scale_card(card, {
				ref_table = card.ability.extra,
				ref_value = "xmult",
				scalar_value = "xmult_gain",
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
