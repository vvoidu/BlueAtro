SMODS.Joker({
	key = "peroro",
	atlas = "blueatro_joker_atlas",
	pos = BlueAtro.id_to_atlas_pos(48),
	config = { extra = { odds = 2, dollars = 1 } },
	rarity = 1,
	cost = 4,
	blueprint_compat = false,
	eternal_compat = true,
	perishable_compat = true,
	loc_vars = function(_, info_queue, card)
		local num, denom = SMODS.get_probability_vars(card, 1, card.ability.extra.odds)
		return { vars = { num, denom, card.ability.extra.dollars } }
	end,
	calculate = function(self, card, context)
		if context.individual and context.cardarea == G.play and not context.blueprint then
			local id = context.other_card:get_id()
			if
				(id == 14 or id == 2 or id == 3)
				and SMODS.pseudorandom_probability(card, card.config.center.key, 1, card.ability.extra.odds)
			then
				card.ability.extra_value = (card.ability.extra_value or 0) + card.ability.extra.dollars
				card:set_cost()
				return {
					message = localize("k_val_up"),
					colour = G.C.MONEY,
					message_card = card,
				}
			end
		end
	end,
})
