SMODS.Joker({
	key = "challenge_letter",
	atlas = "blueatro_joker_atlas",
	pos = BlueAtro.id_to_atlas_pos(44),
	config = { extra = { xmult = 3, bosses_needed = 2, bosses_beaten = 0 } },
	rarity = 2,
	cost = 7,
	blueprint_compat = true,
	eternal_compat = true,
	perishable_compat = true,
	loc_vars = function(_, info_queue, card)
		return {
			vars = { card.ability.extra.xmult, card.ability.extra.bosses_needed, card.ability.extra.bosses_beaten },
		}
	end,

	calculate = function(self, card, context)
		if
			context.beat_boss
			and context.main_eval
			and not context.blueprint
			and card.ability.extra.bosses_beaten < card.ability.extra.bosses_needed
		then
			card.ability.extra.bosses_beaten = card.ability.extra.bosses_beaten + 1
			if card.ability.extra.bosses_beaten >= card.ability.bosses_active then
				return {
					message = localize("k_active_ex"),
					card = card,
				}
			else
				return {
					message = string.format(
						"%d/%d",
						card.ability.extra.bosses_beaten,
						card.ability.extra.bosses_needed
					),
					card = card,
				}
			end
		elseif
			context.joker_main
			and context.main_eval
			and card.ability.extra.bosses_beaten >= card.ability.extra.bosses_needed
		then
			return {
				xmult = card.ability.extra.xmult,
				card = context.blueprint_card or card,
			}
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
				{ ref_table = "card.joker_display_values", ref_value = "active" },
				{ text = ")" },
			},
			calc_function = function(card)
				card.joker_display_values.xmult = (
					card.ability.extra.bosses_needed <= card.ability.extra.bosses_beaten and 3
				) or 1
				card.joker_display_values.active = card.ability.extra.bosses_beaten >= card.ability.bosses_needed
						and localize("k_active")
					or string.format("%d/%d", card.ability.extra.bosses_beaten, card.ability.extra)
			end,
		}
	end,
})
