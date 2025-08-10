SMODS.Joker({
	key = "multitrack_drifting",
	atlas = "blueatro_joker_atlas",
	pos = BlueAtro.id_to_atlas_pos(42),
	config = { extra = {} },
	rarity = 1,
	cost = 6,
	blueprint_compat = true,
	eternal_compat = true,
	perishable_compat = true,
	loc_vars = function(_, info_queue, card) end,
	calculate = function(self, card, context)
		if context.joker_main then
			local poker_hand, _, _, _, _ = G.FUNCS.get_poker_hand_info(G.hand.cards)

			return {
				mult = G.GAME.hands[poker_hand].mult,
				chips = G.GAME.hands[poker_hand].chips,
				card = context.blueprint_card or card,
			}
		end
	end,
	joker_display_def = function(JokerDisplay)
		return {
			text = {
				{ text = "+", colour = G.C.CHIPS },
				{ ref_table = "card.joker_display_values", ref_value = "chips", colour = G.C.CHIPS },
				{ text = " +", colour = G.C.MULT },
				{ ref_table = "card.joker_display_values", ref_value = "mult", colour = G.C.MULT },
			},
			reminder_text = {
				{ text = "(" },
				{ ref_table = "card.joker_display_values", ref_value = "handtype" },
				{ text = ")" },
			},
			calc_function = function(card)
				local unhighlighted = {}
				for _, held in ipairs(G.hand.cards) do
					if not held.highlighted then
						unhighlighted[#unhighlighted + 1] = held
					end
				end
				local poker_hand, disp_text, _, _, _ = G.FUNCS.get_poker_hand_info(unhighlighted)
				if poker_hand == "NULL" then
					poker_hand = "High Card"
					disp_text = localize("High Card", "poker_hands")
				end
				card.joker_display_values.chips = G.GAME.hands[poker_hand].chips
				card.joker_display_values.mult = G.GAME.hands[poker_hand].mult
				card.joker_display_values.handtype = disp_text
			end,
		}
	end,
})
