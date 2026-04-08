local _Game_init_game_object = Game.init_game_object
function Game:init_game_object()
	local ret = _Game_init_game_object(self)
	ret.blueatro_ = ret.current_round.blueatro_or({})
	ret.blueatro_yuzu_combo = { "Flush", "Three of a Kind", "Two Pair" }
	return ret
end

local _smods_calculate_context = SMODS.calculate_context
SMODS.calculate_context = function(context, return_table)
	local ret = _smods_calculate_context(context, return_table)

	if context.after then
		local base_hands = {
			"Pair",
			"Two Pair",
			"Three of a Kind",
			"Straight",
			"Flush",
			"Full House",
			"Four of a Kind",
			-- omitted intentionally
			-- "High Card",
			-- "Straight Flush"
		}
		local next = pseudorandom_element(base_hands, pseudoseed("yuzu_combo"))
		local yuzu_combo = G.GAME.blueatro_yuzu_combo
		table.remove(yuzu_combo, 1)
		yuzu_combo[#yuzu_combo + 1] = next
	end

	return ret
end

SMODS.Joker({
	key = "nyans_dash",
	atlas = "blueatro_joker_atlas",
	pos = BlueAtro.id_to_atlas_pos(21),
	config = { extra = { xmult = 1.0, xmult_gain = 1.0 } },
	rarity = 3,
	cost = 8,
	blueprint_compat = true,
	eternal_compat = true,
	perishable_compat = false,
	loc_vars = function(_, info_queue, card)
		return {
			vars = {
				card.ability.extra.xmult_gain,
				card.ability.extra.xmult,
				localize(G.GAME.blueatro_yuzu_combo[1], "poker_hands"),
				localize(G.GAME.blueatro_yuzu_combo[2], "poker_hands"),
				localize(G.GAME.blueatro_yuzu_combo[3], "poker_hands"),
			},
		}
	end,
	calculate = function(_, card, context)
		if context.joker_main then
			return {
				x_mult = card.ability.extra.xmult,
				card = context.blueprint_card or card,
				colour = G.C.MULT,
			}
		elseif context.before and context.main_eval and not context.blueprint then
			local hand_needed = G.GAME.blueatro_yuzu_combo[1]
			if context.scoring_name == hand_needed then
				SMODS.scale_card(card, {
					ref_table = card.ability.extra,
					ref_value = "xmult",
					scalar_value = "xmult_gain",
					message_colour = G.C.MULT,
				})
				return
			else
				-- Check if redundant reset
				if card.ability.extra.xmult == 1.0 then
					return
				end

				card.ability.extra.xmult = 1.0
				return {
					message = localize("k_reset"),
					colour = G.C.MULT,
				}
			end
		end
	end,
	joker_display_def = function(JokerDisplay)
		return {
			text = {
				{ text = "X", colour = G.C.MULT },
				{ ref_table = "card.joker_display_values", ref_value = "xmult", colour = G.C.MULT },
			},
			reminder_text = {
				{ text = "(" },
				{ ref_table = "card.joker_display_values", ref_value = "next_hand", colour = G.C.ORANGE },
				{ text = ")" },
			},
			calc_function = function(card)
				if next(G.play.cards) then
					return
				end

				local needed_hand = G.GAME.blueatro_yuzu_combo[1]
				card.joker_display_values.next_hand = localize(needed_hand, "poker_hands")

				if #G.hand.highlighted == 0 then
					card.joker_display_values.xmult = card.ability.extra.xmult
					return
				end

				local text, _, _ = JokerDisplay.evaluate_hand()
				if text == needed_hand then
					card.joker_display_values.xmult = card.ability.extra.xmult + card.ability.extra.xmult_gain
				else
					card.joker_display_values.xmult = math.max(1.0, card.ability.extra.xmult / 2)
				end
			end,
		}
	end,
})
