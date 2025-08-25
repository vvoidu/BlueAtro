SMODS.Joker({
	key = "activity_report",
	atlas = "blueatro_joker_atlas",
	pos = BlueAtro.id_to_atlas_pos(40),
	config = { extra = {} },
	rarity = 2,
	cost = 8,
	blueprint_compat = true,
	eternal_compat = true,
	perishable_compat = true,
	loc_vars = function(_, info_queue, card) end,
	calculate = function(self, card, context)
		if context.end_of_round and context.main_eval then
			local valid_hands = {} -- Set to array
			for hand, hand_data in pairs(G.GAME.hands) do
				if hand_data.visible then
					valid_hands[#valid_hands + 1] = hand
				end
			end

			for i = 1, 3 do
				local hand, _ = pseudorandom_element(valid_hands, "activity_report", {})
				SMODS.smart_level_up_hand(card, hand, false)
			end
		end
	end,
})
