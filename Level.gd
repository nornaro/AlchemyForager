extends ItemList

var last = 1
var step = 1000

# Called when the node enters the scene tree for the first time.
func add_levels() -> void:
	clear()
	if last < 1:
		last = 1
	for i in range(last, last+9999):
		if !$"../Search".text || str(i).containsn(str($"../Search".text)):
			add_item(str(i).pad_zeros(11))

	
func _process(delta: float) -> void:
	if Input.is_action_pressed("+1000"):
		last += step
	if Input.is_action_pressed("-1000"):
		last -= step
	if Input.is_action_pressed("+10000"):
		last += step*10
	if Input.is_action_pressed("-10000"):
		last -= step*10
	add_levels()


func calculate_dungeon_difficulty(level: int) -> Dictionary:
	var base_value: int = level
	var extra_points: int = int(level * log(level + 1) / log(2)) - 5 * base_value
	
	# Initialize with base values
	var difficulty: Dictionary = {
		"COMP": base_value,
		"PATK": base_value,
		"PDEF": base_value,
		"MATK": base_value,
		"MDEF": base_value
	}
	
	# Generate random proportions for each stat
	var proportions: Array = [
		randf(),
		randf(),
		randf(),
		randf(),
		randf()
	]
	
	# Calculate the sum of all random values manually
	var total: float = 0.0
	for value in proportions:
		total += value
	
	# Distribute extra points based on proportions
	difficulty["COMP"] += int(extra_points * (proportions[0] / total))
	difficulty["PATK"] += int(extra_points * (proportions[1] / total))
	difficulty["PDEF"] += int(extra_points * (proportions[2] / total))
	difficulty["MATK"] += int(extra_points * (proportions[3] / total))
	difficulty["MDEF"] += int(extra_points * (proportions[4] / total))
	
	# Calculate the total distributed points
	var distributed_points: int = difficulty["COMP"] + difficulty["PATK"] + difficulty["PDEF"] + difficulty["MATK"] + difficulty["MDEF"]
	
	# Handle rounding error by calculating the difference and adding it to a random stat
	var rounding_error: int = (base_value * 5 + extra_points) - distributed_points
	
	if rounding_error > 0:
		# Pick a random stat to add the rounding error
		var stats: Array = ["COMP", "PATK", "PDEF", "MATK", "MDEF"]
		var stat: String = stats[randi_range(0, stats.size() - 1)]
		difficulty[stat] += rounding_error
	
	return difficulty


func _on_item_selected(index: int) -> Dictionary:
	var level = get_item_text(index)
	if !Data.levels.has(level):
		Data.levels[get_item_text(index)] = calculate_dungeon_difficulty(int(level))
	return Data.levels[level]
