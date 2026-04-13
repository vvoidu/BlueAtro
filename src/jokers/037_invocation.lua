SMODS.Joker({
	key = "invocation",
	atlas = "blueatro_joker_atlas",
	pos = BlueAtro.id_to_atlas_pos(37),
	config = { extra = { dollar_req = 10, dollar_counter = 0, chip_gain = 2 } },
	rarity = 1,
	cost = 5,
	blueprint_compat = false,
	eternal_compat = true,
	perishable_compat = true,
	loc_vars = function(self, info_queue, card)
		return {
			vars = { card.ability.extra.dollar_req, card.ability.extra.dollar_counter, card.ability.extra.chip_gain },
		}
	end,
	calculate = function(self, card, context)
		if context.money_altered and context.amount < 0 then
			card.ability.extra.dollar_counter = card.ability.extra.dollar_counter - context.amount
			if card.ability.extra.dollar_counter >= card.ability.extra.dollar_req then
				local times = math.floor(card.ability.extra.dollar_counter / card.ability.extra.dollar_req)
				card.ability.extra.dollar_counter = card.ability.extra.dollar_counter % card.ability.extra.dollar_req

				for _, playing_card in ipairs(G.playing_cards) do
					playing_card.ability.perma_bonus = (playing_card.ability.perma_bonus or 0)
						+ card.ability.extra.chip_gain * times
				end
				card:juice_up()
				return {
					message = localize("k_upgrade_ex"),
					colour = G.C.CHIPS,
				}
			end
		end
	end,
	joker_display_def = function(JokerDisplay)
		return {
			text = {
				{ text = "$", colour = G.C.MONEY },
				{ ref_table = "card.ability.extra", ref_value = "dollar_counter", colour = G.C.MONEY },
				{ text = "/", colour = G.C.MONEY },
				{ ref_table = "card.ability.extra", ref_value = "dollar_req", colour = G.C.MONEY },
			},
		}
	end,
})
