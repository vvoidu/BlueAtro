SMODS.Joker({
	key = "cats_cradle",
	atlas = "blueatro_joker_atlas",
	pos = BlueAtro.id_to_atlas_pos(55),
	config = { extra = {} },
	rarity = 2,
	cost = 8,
	blueprint_compat = false,
	eternal_compat = true,
	perishable_compat = true,
	loc_vars = function(_, info_queue, card)
		info_queue[#info_queue + 1] = { key = "blueatro_furin_kazan", set = "Other", vars = { 1.75 } }
		return {
			vars = {
				card.ability.extra.xmult,
			},
		}
	end,
	calculate = function(_, card, context)
		if
			context.individual
			and context.cardarea == G.hand
			and next(SMODS.get_enhancements(context.other_card))
			and not context.other_card.ability.blueatro_furin_kazan
		then
			local c = context.other_card

			assert(c)
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
					c:add_sticker("blueatro_furin_kazan", true)
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
