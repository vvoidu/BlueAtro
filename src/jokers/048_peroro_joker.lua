SMODS.Joker({
	key = "peroro",
	atlas = "blueatro_joker_atlas",
	pos = BlueAtro.id_to_atlas_pos(48),
	config = { extra = {} },
	rarity = 2,
	cost = 7,
	blueprint_compat = false,
	eternal_compat = true,
	perishable_compat = true,
	loc_vars = function(_, info_queue, card)
		return { vars = {} }
	end,
	calculate = function(self, card, context)
		if context.setting_blind and context.blind.boss and not context.blueprint then
			local pos = BlueAtro.get_card_pos(G.jokers, card)
			local sum = 0
			sum = sum + (G.jokers.cards[pos - 1] and G.jokers.cards[pos - 1].sell_cost or 0)
			sum = sum + (G.jokers.cards[pos + 1] and G.jokers.cards[pos + 1].sell_cost or 0)
			card.ability.extra_value = (card.ability.extra_value or 0) + sum
			card:set_cost()
			return {
				message = localize("k_val_up"),
				colour = G.C.MONEY,
			}
		end
	end,
})
