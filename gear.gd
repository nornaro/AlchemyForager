extends TextureRect

var hired = ""
var statsVisibility = 0

func _ready() -> void:
	$Button.mouse_filter = Control.MOUSE_FILTER_STOP
	$StatsButton.mouse_filter = Control.MOUSE_FILTER_STOP


func hire(hirename) -> void:
	var adventurer = Data.db.select_rows("Adventurer","name ='"+hirename+"'",["*"])[0]
	print(adventurer)
	if hired == hirename:
		hide()
		hired = ""
		$Stats.text = ""
		return
	if hired == "":
		show()
	hired = hirename
	$Stats.text = "[center]"
	$Stats.text += hirename+"\n"
	$Stats.text += "Lelevl: " + str(adventurer.lvl) + " - " + adventurer.class + "\n\n"
	$Stats.text += "Exp: " + str(adventurer.xp) + "\n"
	$Stats.text += "COMP: " + str(adventurer.comp) + "\n"
	$Stats.text += "PATK: " + str(adventurer.patk) + "\n"
	$Stats.text += "PDEF: " + str(adventurer.pdef) + "\n"
	$Stats.text += "MATK: " + str(adventurer.matk) + "\n"
	$Stats.text += "MDEF: " + str(adventurer.mdef) + "\n"
	$Stats.text += "[/center]"
	get_tree().call_group("Body","hide")
	get_node("Body"+adventurer.gender).show()


func _on_stats_button_pressed() -> void:
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
	fire(false)
	
	
func fire(kill: bool):
	if !Data.hired[Data.party].has(hired):
		return
	if %Members.get_node_or_null(Data.party+"/"+hired):
		%Members.get_node(Data.party+"/"+hired).queue_free()
	if !kill:
		Data.hired.Reserve.append(hired)
	if kill:
		Data.hired.Dead.append(hired)
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
