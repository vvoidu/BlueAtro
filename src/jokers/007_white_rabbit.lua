SMODS.Sound({
	key = "e_nihaha",
	path = "e_nihaha.ogg",
})

SMODS.Joker({
	key = "white_rabbit",
	atlas = "blueatro_joker_atlas",
	pos = BlueAtro.id_to_atlas_pos(7),
	config = { extra = { mult = 4 } },
	rarity = 1,
	cost = 5,
	blueprint_compat = true,
	eternal_compat = true,
	perishable_compat = false,
	loc_vars = function(_, info_queue, card)
		local main_end
		if card.edition and card.edition.negative then
			main_end = {}
			localize({ type = "other", key = "remove_negative", nodes = main_end, vars = {} })
		end
		return { vars = { card.ability.extra.mult }, main_end = main_end and main_end[1] }
	end,
	calculate = function(_, card, context)
		if context.joker_main then
			return {
				mult = card.ability.extra.mult,
				card = context.blueprint_card or card,
			}
		elseif context.setting_blind and not context.blueprint then
			if #G.jokers.cards + G.GAME.joker_buffer < G.jokers.config.card_limit then
				G.GAME.joker_buffer = G.GAME.joker_buffer + 1
				G.E_MANAGER:add_event(Event({
					func = function()
						play_sound("blueatro_e_nihaha", 1.0, 0.4)
						local copy = copy_card(card, nil, nil, nil, card.edition and card.edition.negative)
						copy:add_to_deck()
						G.jokers:emplace(copy)
						G.GAME.joker_buffer = 0
						return true
					end,
				}))
				return { message = localize("k_duplicated_ex") }
			else
				return { message = localize("k_no_room_ex") }
			end
		end
	end,
	joker_display_def = function(JokerDisplay)
		return {
			text = {
				{ text = "+", colour = G.C.MULT },
				{ ref_table = "card.ability.extra", ref_value = "mult", colour = G.C.MULT },
			},
		}
	end,
})
