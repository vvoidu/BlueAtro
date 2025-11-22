-- See lovely/scoop.toml for implementation of Chip cap.

SMODS.Joker({
	key = "arcana_rifle",
	atlas = "blueatro_joker_atlas",
	pos = BlueAtro.id_to_atlas_pos(47),
	config = { extra = { xmult = 1, xmult_gain = 1 } },
	rarity = 3,
	cost = 10,
	blueprint_compat = true,
	eternal_compat = true,
	perishable_compat = true,
	loc_vars = function(_, info_queue, card)
		return { vars = { card.ability.extra.xmult_gain, card.ability.extra.xmult } }
	end,
	calculate = function(self, card, context)
		if context.using_consumeable and context.consumeable.ability.set == "Tarot" then
			card.ability.extra.xmult = card.ability.extra.xmult + card.ability.extra.xmult_gain
			return {
				message = localize("k_upgrade_ex"),
				colour = G.C.MULT,
			}
		elseif context.joker_main then
			local xmult = card.ability.extra.xmult
			return {
				xmult = card.ability.extra.xmult,
			}
		elseif context.after and card.ability.extra.xmult ~= self.config.extra.xmult then
			card.ability.extra.xmult = self.config.extra.xmult
			return {
				message = localize("k_reset"),
				colour = G.C.MULT,
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
