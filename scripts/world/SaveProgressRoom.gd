extends Node2D
	
#"lblDescription_save_game_prompt":"Save your progress?",
#"lblDescription_welcome":"Welcome traveler",

enum STATES {
	ENTERED_ROOM,
	LEAVE_ROOM,
	PROMPT_SAVE,
	PROMPT_SAVE_YES,
	PROMPT_SAVE_NO,
}
var selector: int = 0
var state: int = STATES.ENTERED_ROOM
var initialDelay: float = 2.0

func _updateInterface() -> void:
	
	$Canvas/lblDescription.text = ""
func _ready():
	$Canvas/lblTitle.text = LanguageHandler.getText("lblHeader_Inn")

func _physics_process(delta):
	if state != STATES.ENTERED_ROOM:
		pass
		
	_updateInterface() 
	
	


