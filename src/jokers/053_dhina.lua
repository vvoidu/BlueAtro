SMODS.Joker({
	key = "dhina",
	atlas = "blueatro_joker_atlas",
	pos = BlueAtro.id_to_atlas_pos(53),
	config = { extra = { uses = 3 } },
	rarity = 3,
	cost = 9,
	blueprint_compat = false,
	eternal_compat = true,
	perishable_compat = true,
	loc_vars = function(_, info_queue, card)
		return {
			vars = {
				card.ability.extra.uses,
			},
		}
	end,
	calculate = function(_, card, context)
		if
			context.before
			and card.ability.extra.uses > 0
			and BlueAtro.count_filtered(context.full_hand, function(c)
					return c:get_id() == 6
				end)
				== #context.full_hand
		then
			ease_hands_played(1)
			card.ability.extra.uses = card.ability.extra.uses - 1
			return { message = localize({ type = "variable", key = "a_hands", vars = { 1 } }) }
		elseif context.end_of_round and context.main_eval and not context.game_over and not context.blueprint then
			card.ability.extra.uses = 0
		end
	end,
})
