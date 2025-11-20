SMODS.Joker({
	key = "mushiqueen_card",
	atlas = "blueatro_joker_atlas",
	pos = BlueAtro.id_to_atlas_pos(43),
	config = { extra = {} },
	rarity = 3,
	cost = 11,
	blueprint_compat = true,
	eternal_compat = true,
	perishable_compat = true,
	loc_vars = function(_, info_queue, card) end,
	calculate = function(self, card, context)
		if context.before and context.main_eval and #G.scoring_hand == 4 then
			G.E_MANAGER:add_event(Event({
				func = function()
					if #G.jokers.cards + G.GAME.joker_buffer < G.jokers.config.card_limit then
						SMODS.add_card({
							set = "Joker",
							key_append = "mushiqueen",
							rarity = 1,
						})
					end
					return true
				end,
			}))
			return {
				message = localize("k_plus_joker"),
				colour = G.C.BLUE,
			}
		end
	end,
})
