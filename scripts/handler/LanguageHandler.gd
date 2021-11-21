extends Node


# Called when the node enters the scene tree for the first time.
func _ready():
	pass # Replace with function body.

var legend_EN = {
	"lbl_empty": "",
	"lbl_yes": "Yes",
	"lbl_no": "No",
	"lblHeader_welcome":"Welcome traveler",
	"lblHeader_Inn":"Inn",
	"lblDescription_chose_new_members": "Choose new party members?",
	"lblDescription_leaving": "Thank you, see you soon",
	"lblDescription_select_party_member": "Select party member",
	"lblDescription_accept_new_party_prompt": "Keep the current party",
	"lblDescription_confirm_party":"",
	"lblDescription_save_game_prompt":"Save your progress?",
	"lblDescription_welcome":"Welcome traveler",
	"lblOption_unavailable":"Included",
	"lblOption_pooch_name": "Pooch",
	"lblOption_thief_name": "Kaz",
	"lblOption_elf_name": "Nalion",
	"lblOption_wizard_name": "Roan",
	"lblOption_dwarf_name": "Telvar",
	"lblOption_cleric_name": "Raven"
}

func getText(id: String) -> String:
	var value = ""
	if (Global.saveGameData.language == "en"):
		value = legend_EN[id]
	else:
		value = legend_EN[id]
	if value != null:
		return value
	return ""
	
