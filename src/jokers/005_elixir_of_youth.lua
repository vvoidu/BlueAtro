SMODS.Joker({
	key = "elixir_of_youth",
	atlas = "blueatro_joker_atlas",
	pos = BlueAtro.id_to_atlas_pos(5),
	config = { extra = { odds = 3 } },
	rarity = 3,
	cost = 7,
	blueprint_compat = true,
	eternal_compat = true,
	perishable_compat = true,
	loc_vars = function(_, info_queue, card)
		local num, denom = SMODS.get_probability_vars(card, 1, card.ability.extra.odds)

		return { vars = { num, denom } }
	end,
	calculate = function(_, card, context)
		if
			context.individual
			and context.cardarea == G.play
			and context.other_card:is_face()
			and not context.other_card.debuffed
			and SMODS.pseudorandom_probability(card, "elixir", 1, card.ability.extra.odds)
		then
			local c = context.other_card
			assert(c)
			assert(SMODS.modify_rank(c, -1, true))
			-- Sprite needs to be captured here to keep track of all steps if repetitions happen
			local sprite_target = c.config.card
			G.E_MANAGER:add_event(Event({
				trigger = "after",
				delay = 0.4,
				func = function()
					c:flip()
					play_sound("tarot1")
					card:juice_up(0.3, 0.5)
					return true
				end,
			}))
			G.E_MANAGER:add_event(Event({
				trigger = "after",
				delay = 0.2,
				func = function()
					c:set_sprites(nil, sprite_target)
					return true
				end,
			}))
			G.E_MANAGER:add_event(Event({
				trigger = "after",
				delay = 0.15,
				func = function()
					card:juice_up(0.3, 0.5)
					c:flip()
					return true
				end,
			}))
		end
	end,
})
