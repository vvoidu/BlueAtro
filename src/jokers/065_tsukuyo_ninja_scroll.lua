SMODS.Joker({
	key = "tsukuyo_ninja_scroll",
	atlas = "blueatro_joker_atlas",
	pos = BlueAtro.id_to_atlas_pos(65),
	config = { extra = {} },
	rarity = 2,
	cost = 5,
	blueprint_compat = true,
	eternal_compat = true,
	perishable_compat = true,
	loc_vars = function(self, info_queue, card) end,
	calculate = function(self, card, context)
		if
			context.before
			and context.main_eval
			and not context.blueprint
			and context.scoring_name == "Three of a Kind"
			and #context.scoring_hand >= 2
		then
			local first, second = context.scoring_hand[1], context.scoring_hand[2]
			if not first.debuff and not second.debuff then
				G.E_MANAGER:add_event(Event({
					trigger = "after",
					delay = 0.4,
					func = function()
						second:flip()
						play_sound("tarot1")
						card:juice_up(0.3, 0.5)
						return true
					end,
				}))
				G.E_MANAGER:add_event(Event({
					trigger = "after",
					delay = 0.2,
					func = function()
						SMODS.copy_card(first, { new_card = second, playing_card = false })
						return true
					end,
				}))
				G.E_MANAGER:add_event(Event({
					trigger = "after",
					delay = 0.15,
					func = function()
						card:juice_up(0.3, 0.5)
						second:flip()
						return true
					end,
				}))
			end
		end
	end,
})
