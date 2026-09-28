SMODS.Joker({
	key = "banzai_stretch",
	atlas = "blueatro_joker_atlas",
	pos = BlueAtro.id_to_atlas_pos(61),
	config = { extra = {} },
	rarity = 1,
	cost = 6,
	blueprint_compat = true,
	eternal_compat = true,
	perishable_compat = true,
	loc_vars = function(self, info_queue, card) end,
	calculate = function(self, card, context)
		if context.setting_blind or (context.end_of_round and context.main_eval and not context.game_over) then
			local lowest_level, candidates = nil, {}
			for hand, hand_data in pairs(G.GAME.hands) do
				if hand_data.visible then
					if not lowest_level or hand_data.level < lowest_level then
						lowest_level = hand_data.level
						candidates = { hand }
					elseif hand_data.level == lowest_level then
						candidates[#candidates + 1] = hand
					end
				end
			end
			if #candidates > 0 then
				local hand = pseudorandom_element(candidates, pseudoseed("banzai_stretch"))
				SMODS.upgrade_poker_hands({ hands = hand, from = card, instant = false })
			end
		end
	end,
})
