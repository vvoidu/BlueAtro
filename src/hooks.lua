--- Hooks that don't belong under specific files.

SMODS.current_mod.reset_game_globals = function(run_start)
	if run_start then
		G.GAME.blueatro = {}
	end
end

-- After playing a hand, cards marked with `card.blueatro_return_to_hand` are returned to hand instead
G.FUNCS.draw_from_play_to_discard = function(_)
	local play_count = #G.play.cards
	local i = 1
	for _, card in ipairs(G.play.cards) do
		if (not card.shattered) and not card.destroyed then
			if card.blueatro_return_to_hand then
				card.blueatro_return_to_hand = nil
				draw_card(G.play, G.hand, i * 100 / play_count, "up", true, card)
			else
				draw_card(G.play, G.discard, i * 100 / play_count, "down", false, card)
			end
			i = i + 1
		end
	end
end
