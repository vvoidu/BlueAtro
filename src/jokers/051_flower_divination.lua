SMODS.Joker({
	key = "flower_divination",
	atlas = "blueatro_joker_atlas",
	pos = BlueAtro.id_to_atlas_pos(51),
	config = {},
	rarity = 3,
	cost = 8,
	blueprint_compat = true,
	eternal_compat = true,
	perishable_compat = true,
	loc_vars = function(_, info_queue, card)
		return { vars = {} }
	end,
	calculate = function(_, card, context)
		if
			context.individual
			and context.cardarea == G.play
			and not context.end_of_round
			and not context.other_card.debuff
		then
			local pos = BlueAtro.get_card_pos(G.play, context.other_card)
			if pos ~= #G.play.cards then
				return
			end

			local chip_value = 0
			for i = 1, #G.play.cards - 1 do
				local prev_card = G.play.cards[i]
				if not prev_card.debuff then
					chip_value = chip_value + prev_card:get_chip_bonus()
				end
			end

			if chip_value > 0 then
				context.other_card.ability.perma_bonus = (context.other_card.ability.perma_bonus or 0) + chip_value
				return {
					message = localize("k_upgrade_ex"),
					colour = G.C.CHIPS,
				}
			end
		end
	end,
})
