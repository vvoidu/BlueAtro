SMODS.Joker({
	key = "translation_error",
	atlas = "blueatro_joker_atlas",
	pos = BlueAtro.id_to_atlas_pos(26),
	config = {},
	rarity = 3,
	cost = 10,
	blueprint_compat = false,
	eternal_compat = true,
	perishable_compat = false,
	set_card_type_badge = function(self, card, badges)
		badges[#badges + 1] = create_badge(localize("k_mistranslated_rare"), G.C.RARITY[3], G.C.WHITE, 1.2)
	end,
	calculate = function(self, card, context)
		if
			context.post_trigger
			and context.other_card ~= card
			and not context.blueprint
			and context.other_ret.jokers
		then
			local t = context.other_ret.jokers
			local chips = t.chips or t.chip_mod
			if chips then
				-- A Joker might give chips and mult at the same time
				t.mult = chips + (t.mult or 0)
				t.chips = nil
				t.chip_mod = nil
				t.message = nil
			end
		end
	end,
})
