SMODS.Joker({
	key = "fortified_city",
	atlas = "blueatro_joker_atlas",
	pos = BlueAtro.id_to_atlas_pos(57),
	config = {},
	rarity = 2,
	cost = 8,
	blueprint_compat = false,
	eternal_compat = true,
	perishable_compat = true,
	calculate = function(_, card, context)
		if context.before and context.cardarea == G.jokers and not context.blueprint then
			local hand_index = nil
			for i, k in ipairs(G.handlist) do
				if k == context.scoring_name then
					hand_index = i
					break
				end
			end

			for i = hand_index + 1, #G.handlist do
				local drained_hand_name = G.handlist[i]
				local drained_hand = G.GAME.hands[drained_hand_name]
				if drained_hand.visible and drained_hand.level > 1 then
					local upgrades = drained_hand.level - 1
					SMODS.upgrade_poker_hands({ from = card, hands = { context.scoring_name }, level_up = upgrades })
					SMODS.upgrade_poker_hands({ from = card, hands = { drained_hand_name }, level_up = -upgrades })
				end
			end
		end
	end,
})
