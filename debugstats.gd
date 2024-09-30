extends RichTextLabel

@export var partyStatsDefault = {
		"COMP" : 0,
	 	"PATK" : 0, 
		"PDEF" : 0, 
		"MATK" : 0, 
		"MDEF" : 0
	}
var level: Dictionary
var partyStats: Dictionary

func _on_level_item_selected(index: int) -> void:
	partyStats = partyStatsDefault.duplicate(true)
	level = Data.levels[$"../../Level".get_item_text(index)]
	text = ""
	if !Data.party:
		return
	for member in Data.db.select_rows("Adventurer","party ='"+Data.party+"'",partyStats.keys()):
		for stat in partyStats.keys():
			partyStats[stat] += member.get(stat)
			
	for stat in partyStats.keys():
		text += stat + ": " + str(partyStats[stat]) + "\n"
	_on_predict_pressed()


func _on_start_pressed() -> void:
	var condition = 0
	for i in 3:
		var stat = partyStats.keys()[randi_range(0,4)]
		if partyStats.get(stat) > level.get(stat):
			condition += 1 # SUCCESS
		if partyStats.get(stat) < level.get(stat):
			condition -= 1 # FAIL Possible item loss
	$"../Result".text = "[center]"
	match condition:
		0: 
			$"../Result".text += "Tie \nNo negative effect"
		-1: 
			$"../Result".text += "Defeat \n"
			if randi_range(0,1) == 0:
				if Data.hired.get(Data.party):
					$"../Result".text += "Character lost"
					%Gear.hired = Data.hired.get(Data.party).pick_random()
					%Gear.fire(true)
				
		-2: 
			if Data.hired.get(Data.party):
				$"../Result".text += "Defeat \nCharacter lost"
				%Gear.hired = Data.hired.get(Data.party).pick_random()
				%Gear.fire(true)
			
		-3: 
			$"../Result".text += "Critical defeat \nCharacter lost"
			if Data.hired.get(Data.party):
				%Gear.hired = Data.hired.get(Data.party).pick_random()
				%Gear.fire(true)
			if randi_range(0,3) == 0:
				$"../Result".text += "\nTeam lost"
				for member in Data.hired.get(Data.party):
					%Gear.hired = member
					%Gear.fire(true)
		_: 
			$"../Result".text += "\nVictory"
	$"../Result".text += "[/center]"


func _on_predict_pressed() -> void:
	var result = 0
	for i in 9999:
		result += mock_battle()
	result = round(float(result)/100)
	if result <= 1:
		%Predict.text = "[center][color=black]"+ str(result) + "[/color][/center]"
	if result > 1:
		%Predict.text = "[center][color=red]"+ str(result) + "[/color][/center]"
	if result > 25:
		%Predict.text = "[center][color=orange]"+ str(result) + "[/color][/center]"
	if result > 50:
		%Predict.text = "[center][color=yellow]"+ str(result) + "[/color][/center]"
	if result > 75:
		%Predict.text = "[center][color=lime]"+ str(result) + "[/color][/center]"
	if result == 99:
		%Predict.text = "[center][color=green]"+ str(result) + "[/color][/center]"
	
func mock_battle() -> int:
	var condition = 0
	for i in 3:
		var stat = partyStats.keys()[randi_range(0,4)]
		if partyStats.get(stat) > level.get(stat):
			condition += 1 # SUCCESS
		if partyStats.get(stat) < level.get(stat):
			condition -= 1 # FAIL Possible item loss
	if condition > 0:
		return 1
	return 0
