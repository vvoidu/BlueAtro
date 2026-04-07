local _new_round = new_round
function new_round()
	G.GAME.blueatro_first_discard = nil
	_new_round()
end

local G_FUNCS_discard_cards_from_highlighted = G.FUNCS.discard_cards_from_highlighted
G.FUNCS.discard_cards_from_highlighted = function(e, hook)
	if G.GAME.blueatro_first_discard == nil then
		G.GAME.blueatro_first_discard = {}
		for i, c in ipairs(G.hand.highlighted) do
			G.GAME.blueatro_first_discard[i] = c.sort_id
		end
	end
	G_FUNCS_discard_cards_from_highlighted(e, hook)
end

SMODS.Joker({
	key = "harmonica",
	atlas = "blueatro_joker_atlas",
	pos = BlueAtro.id_to_atlas_pos(49),
	config = { extra = {} },
	rarity = 1,
	cost = 5,
	blueprint_compat = false,
	eternal_compat = true,
	perishable_compat = true,
	loc_vars = function(_, info_queue, card)
		return { vars = {} }
	end,
	calculate = function(self, card, context)
		if
			context.hand_drawn
			and not context.blueprint
			and G.GAME.blueatro_first_discard
			and #G.GAME.blueatro_first_discard > 0
			and G.GAME.current_round.discards_left == 0
		then
			-- Holy O(N)
			card:juice_up()
			for _, id in ipairs(G.GAME.blueatro_first_discard) do
				for _, c in ipairs(G.discard.cards) do
					if c.sort_id == id then
						draw_card(G.discard, G.hand, 100, "up", false, c)
					end
				end
			end
		end
	end,
})
