SMODS.Joker({
	key = "free_trade",
	atlas = "blueatro_joker_atlas",
	pos = BlueAtro.id_to_atlas_pos(63),
	config = { extra = { sell_price = 6 } },
	rarity = 2,
	cost = 8,
	blueprint_compat = true,
	eternal_compat = true,
	perishable_compat = true,
	loc_vars = function(self, info_queue, card)
		return { vars = { card.ability.extra.sell_price } }
	end,
	calculate = function(self, card, context)
		if context.card_added then
			context.card.sell_cost = card.ability.extra.sell_price
		end
	end,
})
