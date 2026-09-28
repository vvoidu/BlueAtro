SMODS.Joker({
	key = "quality_assurance",
	atlas = "blueatro_joker_atlas",
	pos = BlueAtro.id_to_atlas_pos(68),
	config = { extra = { xmult = 2 } },
	rarity = 2,
	cost = 6,
	blueprint_compat = true,
	eternal_compat = true,
	perishable_compat = true,
	loc_vars = function(self, info_queue, card)
		return { vars = { card.ability.extra.xmult } }
	end,
	calculate = function(self, card, context)
		if context.joker_main then
			-- the current hand is already counted by the time jokers score
			if G.GAME.hands[context.scoring_name].played <= 1 then
				return
			end

			if G.jokers.cards[1] == card then
				return
			end

			local usage = G.GAME.consumeable_usage_total or {}
			if (usage.tarot or 0) == 0 or (usage.planet or 0) == 0 then
				return
			end

			local has_heart = BlueAtro.count_filtered(context.scoring_hand, function(c)
				return c:is_suit("Hearts")
			end, true) > 0
			if not has_heart then
				return
			end

			local holds_heart = BlueAtro.count_filtered(G.hand.cards, function(c)
				return c:is_suit("Hearts")
			end) > 0
			if not holds_heart then
				return
			end

			local deck_ranks = {}
			for _, c in ipairs(G.playing_cards) do
				if not SMODS.has_no_rank(c) then
					deck_ranks[c:get_id()] = true
				end
			end
			for _, c in ipairs(context.scoring_hand) do
				if not SMODS.has_no_rank(c) and not deck_ranks[c:get_id()] then
					return
				end
			end

			return {
				x_mult = card.ability.extra.xmult,
				colour = G.C.MULT,
				card = context.blueprint_card or card,
			}
		end
	end,
	joker_display_def = function(JokerDisplay)
		return {
			text = {
				{ text = "X", colour = G.C.MULT },
				{ ref_table = "card.ability.extra", ref_value = "xmult", colour = G.C.MULT },
			},
		}
	end,
})
