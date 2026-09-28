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
		if context.discard and not context.blueprint then
			local text, _, _, scoring_hand = G.FUNCS.get_poker_hand_info(context.full_hand)
			if text == "Two Pair" then
				local higher_id
				for _, c in ipairs(scoring_hand) do
					local id = c:get_id()
					if not higher_id or id > higher_id then
						higher_id = id
					end
				end
				card:juice_up()
				if context.other_card:get_id() == higher_id then
					return { remove = true }
				end
			end
		end
	end,
})
