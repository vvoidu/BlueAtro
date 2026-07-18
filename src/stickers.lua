SMODS.Atlas({
	key = "blueatro_stickers_atlas",
	path = "stickers.png",
	px = 71,
	py = 95,
})

SMODS.Sticker({
	key = "furin_kazan",
	atlas = "blueatro_stickers_atlas",
	pos = { x = 0, y = 0 },
	badge_colour = HEX("E37DFF"),
	config = { extra = { xmult = 1.75 } },
	loc_vars = function(self, info_queue, card)
		return { vars = { self.config.extra.xmult } }
	end,
	rate = 0.0,
	default_compat = false,
	compat_exceptions = {},
	calculate = function(self, card, context)
		if context.main_scoring and context.cardarea == G.play then
			G.E_MANAGER:add_event(Event({
				trigger = "after",
				func = function()
					card:remove_sticker(self.key)
					return true
				end,
			}))
			return {
				xmult = self.config.extra.xmult,
			}
		end
	end,
})
