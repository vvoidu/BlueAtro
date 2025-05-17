SMODS.Joker({
	key = "overtime",
	atlas = "blueatro_joker_atlas",
	pos = BlueAtro.id_to_atlas_pos(36),
	config = {},
	rarity = 1,
	cost = 5,
	blueprint_compat = true,
	eternal_compat = true,
	perishable_compat = false,
	calculate = function(self, card, context)
		if context.joker_main then
			G.GAME.blueatro_overtime_list = G.GAME.blueatro_overtime_list or {}
			G.GAME.blueatro_overtime_list[#G.GAME.blueatro_overtime_list + 1] = context.blueprint_card or card
		end
	end,
})
