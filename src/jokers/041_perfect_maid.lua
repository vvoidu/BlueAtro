SMODS.Sound({
	key = "e_pyon",
	path = "e_pyon.wav",
})
SMODS.Joker({
	key = "perfect_maid",
	atlas = "blueatro_joker_atlas",
	pos = BlueAtro.id_to_atlas_pos(41),
	config = { extra = {} },
	rarity = 1,
	cost = 4,
	blueprint_compat = false,
	eternal_compat = true,
	perishable_compat = true,
	loc_vars = function(_, info_queue, card) end,
	calculate = function(self, card, context)
		if context.before and context.main_eval and not context.blueprint then
			play_sound("blueatro_e_pyon")
			for _, c in ipairs(G.hand.cards) do
				if not c.highlighted then
					G.hand.highlighted[#G.hand.highlighted + 1] = c
					c:highlight(true)
				end
			end
			G.FUNCS.discard_cards_from_highlighted({}, true)
		end
	end,
})
