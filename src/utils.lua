--- @param id integer
BlueAtro.id_to_atlas_pos = function(id)
	return { x = id % 10, y = math.floor(id / 10) }
end

--- @param array table
--- @param filter function
--- @param count_debuffed boolean?
BlueAtro.count_filtered = function(array, filter, count_debuffed)
	count_debuffed = count_debuffed or false
	local count = 0
	for _, x in ipairs(array) do
		if count_debuffed and x.debuff then
			goto continue
		end
		if filter(x) then
			count = count + 1
		end
		::continue::
	end
	return count
end

--- @param target_chips integer
BlueAtro.ease_blind_chips = function(target_chips)
	local decreasing = target_chips < G.GAME.blind.chips
	local diff = target_chips - G.GAME.blind.chips

	local event
	event = Event({
		trigger = "after",
		blocking = true,
		delay = 0.1,
		func = function()
			G.GAME.blind.chips = G.GAME.blind.chips + diff / 10
			if
				(decreasing and G.GAME.blind.chips > target_chips)
				or (not decreasing and G.GAME.blind.chips < target_chips)
			then
				G.GAME.blind.chip_text = number_format(G.GAME.blind.chips)
				play_sound("chips1")
				event.start_timer = false
			else
				G.GAME.blind.chips = target_chips
				G.GAME.blind.chip_text = number_format(target_chips)
				G.GAME.blind:wiggle()
				return true
			end
		end,
	})
	G.E_MANAGER:add_event(event)
end

--- @param sound string?
BlueAtro.pop_card = function(card, sound)
	if card == nil then
		return
	end
	sound = sound or "tarot1"
	G.E_MANAGER:add_event(Event({
		func = function()
			play_sound(sound)
			card.T.r = -0.2
			card:juice_up(0.3, 0.4)
			card.states.drag.is = true
			card.children.center.pinch.x = true
			G.E_MANAGER:add_event(Event({
				trigger = "after",
				delay = 0.3,
				blockable = false,
				func = function()
					G.jokers:remove_card(card)
					card:remove()
					card = nil
					return true
				end,
			}))
			return true
		end,
	}))
end

---@param array table
---@param src_index integer
---@param target_index integer
BlueAtro.move_to_index = function(array, src_index, target_index)
	local to_wraparound = array[src_index]
	local step = src_index < target_index and 1 or -1

	for i = src_index, target_index - step, step do
		array[i] = array[i + step]
	end
	array[target_index] = to_wraparound
end

---@param card Card
BlueAtro.get_card_pos = function(cardarea, card)
	for i = 1, #cardarea.cards do
		if cardarea.cards[i] == card then
			return i
		end
	end
end

---Force a card to be scored exactly once.
---@param card Card
---@param context CalcContext
BlueAtro.force_score_card = function(card, context)
	context.main_scoring = true
	local effects = { eval_card(card, context) }
	SMODS.calculate_quantum_enhancements(card, effects, context)
	context.main_scoring = nil

	context.individual = true
	context.other_card = card
	if next(effects) then
		SMODS.calculate_card_areas("jokers", context, effects, { main_scoring = true })
		SMODS.calculate_card_areas("individual", context, effects, { main_scoring = true })
	end

	SMODS.trigger_effects(effects, card)
end
