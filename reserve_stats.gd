extends RichTextLabel


func _on_hired_item_selected(index: int) -> void:
	text = ""
	var hire = Data.hires[$"../../Reserves/Hired".get_item_text(index)]
	text += "LVL: " + str(hire.LVL) + "\n"
	text += "CLASS: " + hire.CLASS + "\n"
	text += "COMP: " + str(hire.COMP) + "\n"
	text += "PATK: " + str(hire.PATK) + "\n"
	text += "PDEF: " + str(hire.PDEF) + "\n"
	text += "MATK: " + str(hire.MATK) + "\n"
	text += "MDEF: " + str(hire.MDEF) + "\n"
	pass # Replace with function body.
