extends RichTextLabel

@export var partyStats: Dictionary 
var level: Dictionary

func _on_level_item_selected(index: int) -> void:
	level = Data.levels[$"../Level".get_item_text(index)]
	text = ""
	partyStats= {
		"COMP" : 0,
	 	"PATK" : 0, 
		"PDEF" : 0, 
		"MATK" : 0, 
		"MDEF" : 0
	}
	if !Data.party:
		return
	print(Data.hired.get(Data.party))
	for member in Data.hired.get(Data.party):
		print(member)
		for stat in partyStats.keys():
			partyStats[stat] += Data.hires.get(member).get(stat)
			
	for stat in partyStats.keys():
		text += stat + ": " + str(partyStats[stat]) + "\n"
	print(partyStats)


func _on_start_pressed() -> void:
	var condition = 0
	for i in 3:
		var stat = partyStats.keys()[randi_range(0,4)]
		if partyStats.get(stat) > level.get(stat):
			condition += 1 # SUCCESS
		if partyStats.get(stat) < level.get(stat):
			condition -= 1 # FAIL Possible item loss
	match condition:
		0: text+="\nTie, \nNo negative effect"
		-1: text+="\nDefeat, \n50% possible character loss"
		-2: text+="\nDefeat, \nCharacter loss"
		-3: text+="\nCritical defeat, \ncharacter loss, 25% possible team loss"
		_: text+="\nVictory"


func _on_predict_pressed() -> void:
	var result = 0
	for i in 9999:
		result += mock_battle()
	text += str(result/100)
	
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
