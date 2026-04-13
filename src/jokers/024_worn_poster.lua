SMODS.Sound({
	key = "e_rip",
	path = "e_rip.ogg",
})

SMODS.Joker({
	key = "worn_poster",
	atlas = "blueatro_joker_atlas",
	pos = BlueAtro.id_to_atlas_pos(24),
	config = {},
	rarity = 1,
	cost = 3,
	blueprint_compat = false,
	eternal_compat = false,
	perishable_compat = true,
	calculate = function(_, card, context)
		play_sound("blueatro_e_rip", 1.0, 1.0)
		if context.joker_type_destroyed and context.card == card then
			G.E_MANAGER:add_event(Event({
				func = function()
					if #G.jokers.cards + G.GAME.joker_buffer < G.jokers.config.card_limit then
						SMODS.add_card({
							set = "Joker",
							key_append = "abydos_poster",
							rarity = 1,
						})
					end
					return true
				end,
			}))
		end
	end,
})
