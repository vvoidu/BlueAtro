SMODS.Joker({
	key = "hydrodynamics",
	atlas = "blueatro_joker_atlas",
	pos = BlueAtro.id_to_atlas_pos(67),
	config = {},
	rarity = 2,
	cost = 5,
	blueprint_compat = false,
	eternal_compat = true,
	perishable_compat = true,
	loc_vars = function(self, info_queue, card)
		return {}
	end,
	calculate = function(self, card, context)
		if context.pre_discard and not context.blueprint then
			-- Evaluate the discarded hand once; context.discard then fires per card
			card.blueatro_hydro_target = nil
			local text, _, _, scoring_hand = G.FUNCS.get_poker_hand_info(context.full_hand)
			if text == "Two Pair" then
				local higher_id
				for _, c in ipairs(scoring_hand) do
					local id = c:get_id()
					if not higher_id or id > higher_id then
						higher_id = id
					end
				end
				card.blueatro_hydro_target = higher_id
			end
		elseif context.discard and not context.blueprint and card.blueatro_hydro_target then
			card:juice_up()
			if context.other_card:get_id() == card.blueatro_hydro_target then
				return { remove = true }
			end
		end
	end,
})
