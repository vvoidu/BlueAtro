SMODS.Joker({
	key = "pillow_fight",
	atlas = "blueatro_joker_atlas",
	pos = BlueAtro.id_to_atlas_pos(38),
	config = {},
	rarity = 2,
	cost = 7,
	blueprint_compat = true,
	eternal_compat = true,
	perishable_compat = true,
	loc_vars = function(self, info_queue, card)
		return {}
	end,
	calculate = function(_, card, context)
		if context.repetition and context.cardarea == G.play and not context.other_card.debuff then
			local other = context.other_card
			if other and other.ability.effect == "Base" and other.edition == nil then
				return {
					message = localize("k_again_ex"),
					repetitions = 1,
					card = card,
				}
			end
		end
	end,
})
