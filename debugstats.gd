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
		print(stat)
		if partyStats.get(stat) > level.get(stat):
			condition += 1
		if partyStats.get(stat) < level.get(stat):
			condition -= 1
	print(condition)
	pass # Replace with function body.
