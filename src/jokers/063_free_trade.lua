SMODS.Joker({
	key = "free_trade",
	atlas = "blueatro_joker_atlas",
	pos = BlueAtro.id_to_atlas_pos(63),
	config = { extra = { sell_price = 6 } },
	rarity = 2,
	cost = 8,
	blueprint_compat = false,
	eternal_compat = true,
	perishable_compat = true,
	loc_vars = function(self, info_queue, card)
		return { vars = { card.ability.extra.sell_price } }
	end,
	calculate = function(self, card, context)
		if context.card_added then
			local target = context.card
			assert(target)
			target:set_cost()
			target.ability.extra_value = (target.ability.extra_value or 0)
				+ (card.ability.extra.sell_price - target.sell_cost)
			target:set_cost()
		end
	end,
})
