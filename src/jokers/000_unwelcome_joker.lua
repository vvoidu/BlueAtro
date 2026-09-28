SMODS.Sound({
	key = "e_explosion",
	path = "e_explosion.ogg",
})

SMODS.Joker({
	key = "unwelcome_joker",
	atlas = "blueatro_joker_atlas",
	pos = BlueAtro.id_to_atlas_pos(0),
	config = { extra = {} },
	rarity = 2,
	cost = 5,
	blueprint_compat = false,
	eternal_compat = false,
	perishable_compat = true,
	loc_vars = function(self, info_queue, card) end,
	calculate = function(self, card, context)
		if context.destroy_card and (context.cardarea == G.play or context.cardarea == "unscored") then
			return {
				remove = true,
			}
		elseif context.after and context.main_eval then
			G.E_MANAGER:add_event(Event({
				trigger = "after",
				func = function()
					play_sound("blueatro_e_explosion")
					SMODS.destroy_cards({ card }, { bypass_eternal = true })
					return true
				end,
			}))
		end
	end,
})
