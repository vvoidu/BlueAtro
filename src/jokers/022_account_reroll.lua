SMODS.Joker({
	key = "account_reroll",
	atlas = "blueatro_joker_atlas",
	pos = BlueAtro.id_to_atlas_pos(22),
	config = {},
	rarity = 3,
	cost = 7,
	blueprint_compat = false,
	eternal_compat = true,
	perishable_compat = true,
	loc_vars = function(_, info_queue, card) end,
	calculate = function(_, card, context)
		if context.reroll_shop and not context.retrigger_joker then
			local pos = BlueAtro.get_card_pos(G.jokers, card)
			if pos == nil then
				return
			end

			local next_joker = G.jokers.cards[pos + 1]
			if next_joker and not next_joker.getting_sliced then
				-- next_joker is still in the area while it dissolves, so check room as if it were
				-- already gone (including any slots it gives, e.g. Negative, or takes up).
				local ability = next_joker.ability
				local has_room = #G.jokers.cards - 1 + G.GAME.joker_buffer
					< G.jokers.config.card_limit - (ability.card_limit or 0) + (ability.extra_slots_used or 0)

				local destroyed = SMODS.destroy_cards(next_joker)
				if not destroyed or #destroyed == 0 then
					return
				end
				if has_room then
					G.GAME.joker_buffer = G.GAME.joker_buffer + 1
				end

				G.E_MANAGER:add_event(Event({
					func = function()
						card:juice_up(0.8)
						if has_room then
							SMODS.add_card({
								set = "Joker",
								key_append = "risemara",
							})
							G.GAME.joker_buffer = 0
							-- Take the destroyed joker's spot.
							local target = BlueAtro.get_card_pos(G.jokers, next_joker)
							if target then
								BlueAtro.move_to_index(G.jokers.cards, #G.jokers.cards, target)
							end
							play_sound("generic1")
							SMODS.calculate_effect({
								message = localize("k_blueatro_rerolled"),
							}, card)
						else
							SMODS.calculate_effect({
								message = localize("k_no_room_ex"),
							}, card)
						end
						return true
					end,
				}))
			end
		end
	end,
})
