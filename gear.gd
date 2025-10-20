extends TextureRect

var hired:String = ""
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


func _on_confirm_axe_pressed() -> void:
	$Axe/ConfirmFire.hide()
	fire(false)
	
	
func fire(kill: bool):
	if hired == "":
		return # nothing selected
	
	# Remove the member node from the party UI if it exists
	var member_node_path = Data.party + "/" + hired
	var member_node = %Members.get_node_or_null(member_node_path)
	if member_node:
		member_node.queue_free()
	
	# Fetch the adventurer row
	var adventurer_rows = Data.db.select_rows("Adventurer", "name = '" + hired + "'", ["*"])
	if adventurer_rows.size() == 0:
		hired = ""
		return
	
	var adventurer = adventurer_rows[0]
	
	if kill:
		adventurer["party"] = "Dead"
		adventurer["lvl"] = -abs(adventurer["lvl"])
		Data.db.update_rows("Adventurer", "id = " + str(adventurer["id"]), adventurer)
		return
	Data.db.update_rows("Adventurer", "id = " + str(adventurer["id"]), {"party": "free"})
	if %Hired.has_node(hired):
		%Hired.get_node(hired).queue_free()
	%Hired.add_item(hired)
	%Hires.add_item(hired)
	
func _on_timer_timeout() -> void:
	$Axe/ConfirmFire.hide()
