-- Why not use add_to_deck and remove_from_deck and set G.GAME.joker_rate to 0?
-- What if some other mod thing wants to modify that?
-- This covers both the vanilla path and SMODS.create_shop_card.
local _create_card_for_shop = create_card_for_shop
function create_card_for_shop(area)
	if not next(SMODS.find_card("j_blueatro_descartes")) then
		return _create_card_for_shop(area)
	end
	local joker_rate = G.GAME.joker_rate
	G.GAME.joker_rate = 0
	local card = _create_card_for_shop(area)
	G.GAME.joker_rate = joker_rate
	return card
end

SMODS.Joker({
	key = "descartes",
	atlas = "blueatro_joker_atlas",
	pos = BlueAtro.id_to_atlas_pos(31),
	config = {},
	rarity = 1,
	cost = 2,
	blueprint_compat = false,
	eternal_compat = true,
	perishable_compat = true,
	loc_vars = function(self, info_queue, card) end,
	calculate = function(self, card, context) end,
})
