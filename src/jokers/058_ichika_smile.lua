SMODS.Joker({
	key = "ichika_smile",
	atlas = "blueatro_joker_atlas",
	pos = BlueAtro.id_to_atlas_pos(58),
	config = { extra = { hands = 2 } },
	rarity = 1,
	cost = 6,
	blueprint_compat = true,
	eternal_compat = false,
	perishable_compat = true,
	loc_vars = function(_, loc_vars, card)
		return { vars = { card.ability.extra.hands } }
	end,
	add_to_deck = function(self, card, from_debuff)
		G.GAME.round_resets.hands = G.GAME.round_resets.hands + card.ability.extra.hands
		ease_hands_played(card.ability.extra.hands)
	end,
	remove_from_deck = function(self, card, from_debuff)
		G.GAME.round_resets.hands = G.GAME.round_resets.hands - card.ability.extra.hands
	end,
	calculate = function(_, card, context)
		-- press_play is calculated *before* the hand is used
		if context.press_play and G.GAME.current_round.hands_left == 1 then
			SMODS.destroy_cards(card, { bypass_eternal = true })
		end
	end,
})
