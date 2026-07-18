SMODS.Joker({
	key = "tsuchinoko_search",
	atlas = "blueatro_joker_atlas",
	pos = BlueAtro.id_to_atlas_pos(56),
	config = { extra = { xmult = 4 } },
	rarity = 2,
	cost = 6,
	blueprint_compat = true,
	eternal_compat = true,
	perishable_compat = true,
	loc_vars = function(_, info_queue, card)
		local enhanced_count = BlueAtro.count_filtered(G.playing_cards or {}, function(c)
			return next(SMODS.get_enhancements(c))
		end, true)
		return {
			vars = {
				card.ability.extra.xmult,
				enhanced_count,
			},
		}
	end,
	calculate = function(_, card, context)
		if context.individual and next(SMODS.get_enhancements(context.other_card)) and context.cardarea == G.play then
			local enhanced_count = BlueAtro.count_filtered(G.playing_cards, function(c)
				return next(SMODS.get_enhancements(c))
			end, true)
			if enhanced_count == 4 then
				return {
					xmult = card.ability.extra.xmult,
				}
			end
		end
	end,
	joker_display_def = function(JokerDisplay)
		return {
			reminder_text = {
				{ text = "(", colour = G.C.UI.TEXT_INACTIVE },
				{ ref_table = "card.joker_display_values", ref_value = "count" },
				{ text = "/4" },
				{ text = ")", colour = G.C.UI.TEXT_INACTIVE },
			},
			calc_function = function(card)
				card.joker_display_values.count = BlueAtro.count_filtered(G.playing_cards, function(c)
					return next(SMODS.get_enhancements(c))
				end, true)
			end,
			style_function = function(card, text, reminder_text, extra)
				if reminder_text and reminder_text.children then
					local colour = card.joker_display_values.active and G.C.GREEN or G.C.UI.TEXT_INACTIVE
					if reminder_text.children[2] then
						reminder_text.children[2].config.colour = colour
					end
					if reminder_text.children[3] then
						reminder_text.children[3].config.colour = colour
					end
				end
			end,
		}
	end,
})
