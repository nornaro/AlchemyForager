extends TextureRect

var float_in = false
var hired = ""
var statsVisibility = 0

func _ready() -> void:
	$Button.mouse_filter = Control.MOUSE_FILTER_STOP
	$StatsButton.mouse_filter = Control.MOUSE_FILTER_STOP


func hire(hirename) -> void:
	if hired == hirename:
		float_in = false
		hired = ""
		$Stats.text = ""
		return
	if hired == "":
		float_in = true
	hired = hirename
	$Stats.text = "[center]"
	$Stats.text += str(Data.hires[hirename]["NAME"])+"\n"
	$Stats.text += "Lelevl: 1 - " + str(Data.hires[hirename]["CLASS"])+"\n\n"
	$Stats.text += "Exp: " + str(Data.hires[hirename]["EXP"])+"\n"
	$Stats.text += "COMP: " + str(Data.hires[hirename]["COMP"])+"\n"
	$Stats.text += "PATK: " + str(Data.hires[hirename]["PATK"])+"\n"
	$Stats.text += "PDEF: " + str(Data.hires[hirename]["PDEF"])+"\n"
	$Stats.text += "MATK: " + str(Data.hires[hirename]["MATK"])+"\n"
	$Stats.text += "MDEF: " + str(Data.hires[hirename]["MDEF"])+"\n"
	$Stats.text += "[/center]"


# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(delta: float) -> void:
	if float_in && position.x < 0:
		position.x += 200
	if !float_in && position.x > -700:
		position.x -= 200


func _on_stats_button_pressed() -> void:
	print(statsVisibility)
	statsVisibility += 1
	if statsVisibility == 3:
		statsVisibility = 0
	match statsVisibility:
		0: 
			$BG.hide()
			$Stats.hide()
		1:
			$BG.hide()
			$Stats.show()
		2:
			$BG.show()
			$Stats.show()
		

func _on_axe_pressed() -> void:
	$Axe/Timer.start()
	$Axe/ConfirmFire.show()


func _on_confirm_fire_pressed() -> void:
	$Axe/ConfirmFire.hide()
	if !Data.hired[Data.party].has(hired):
		return
	if %Members.get_node_or_null(Data.party+"/"+hired):
		%Members.get_node(Data.party+"/"+hired).queue_free()
	Data.hired.Reserve.append(hired)
	for i in range(Data.hired[Data.party].size()-1):
		if Data.hired[str(Data.party)][i] != hired:
			continue
		Data.hired[str(Data.party)].remove_at(i)
	if Data.hired[Data.party].size() == 1:
		Data.hired[Data.party].clear()
	Data.hired[Data.party].erase(hired)
	Data.write("hired")
	%"Reserves/Hired"._ready()
	
func _on_timer_timeout() -> void:
	$Axe/ConfirmFire.hide()
