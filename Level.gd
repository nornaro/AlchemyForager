extends ItemList

var last = 1
var step = 1000

func _ready() -> void:
	$"../../TopContainer/Search".text = ""
	$"../../TopContainer/DropTier".text = ""
	add_levels()

func add_levels() -> void:
	clear()
	if last < 1:
		last = 1
	last = int(round(float(last) / 1000.0)) * 1000
	for i in range(last, last+999):
		if !$"../../TopContainer/Search".text || str(i).containsn(str(!$"../../TopContainer/Search".text)):
			add_item(str(i).pad_zeros(9))

func _process(_delta: float) -> void:
	if Input.is_action_pressed("+1000"):
		last += step
		add_levels()
	if Input.is_action_pressed("-1000"):
		last -= step
		add_levels()
	if Input.is_action_pressed("+10000"):
		last += step*10
		add_levels()
	if Input.is_action_pressed("-10000"):
		last -= step*10
		add_levels()


func calculate_dungeon_difficulty(level: int) -> Dictionary:
	var base_value: float = level
	var extra_points: int = round(level * log(level + 1) / log(2)) - 5 * base_value
	
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
	var rounding_error: int = round(base_value * 5 + extra_points) - distributed_points
	
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
