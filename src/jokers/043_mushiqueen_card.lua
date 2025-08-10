SMODS.Joker({
	key = "mushiqueen_card",
	atlas = "blueatro_joker_atlas",
	pos = BlueAtro.id_to_atlas_pos(43),
	config = { extra = { odds = 2 } },
	rarity = 1,
	cost = 6,
	blueprint_compat = true,
	eternal_compat = true,
	perishable_compat = true,
	loc_vars = function(_, info_queue, card)
		return { vars = { (G.GAME.probabilities.normal or 1), card.ability.extra.odds } }
	end,
	calculate = function(self, card, context)
		if context.before and context.main_eval and #G.play.cards == 4 then
			if pseudorandom(pseudoseed("nanikorehennano")) < G.GAME.probabilities.normal / card.ability.extra.odds then
				G.E_MANAGER:add_event(Event({
					func = function()
						if #G.jokers.cards + G.GAME.joker_buffer < G.jokers.config.card_limit then
							SMODS.add_card({
								set = "Joker",
								key_append = "mushiqueen",
								rarity = 0,
							})
						end
						return true
					end,
				}))
			end
			return {
				message = localize("k_plus_joker"),
				colour = G.C.BLUE,
			}
		end
	end,
})
