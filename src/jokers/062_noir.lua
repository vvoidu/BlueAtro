SMODS.Joker({
	key = "noir",
	atlas = "blueatro_joker_atlas",
	pos = BlueAtro.id_to_atlas_pos(62),
	config = {},
	rarity = 2,
	cost = 6,
	blueprint_compat = true,
	eternal_compat = true,
	perishable_compat = true,
	loc_vars = function(self, info_queue, card)
		return {}
	end,
	calculate = function(_, card, context)
		if context.repetition and context.cardarea == G.play and not context.other_card.debuff then
			local other_uncommons = BlueAtro.count_filtered(G.jokers.cards, function(j)
				return j ~= card and j:is_rarity(2)
			end, true)
			if other_uncommons == 0 then
				return {
					message = localize("k_again_ex"),
					repetitions = 1,
					card = card,
				}
			end
		end
	end,
})
