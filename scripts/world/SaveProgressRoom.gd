extends Node2D
	
#"lblDescription_save_game_prompt":"Save your progress?",
#"lblDescription_welcome":"Welcome traveler",

enum STATES {
	ENTERED_ROOM,
	LEAVE_ROOM,
	PROMPT_ACTION,
	PROMPT_ACTION_SAVE,
	SELECTED_ACTION_SAVE,
	SELECTED_ACTION_SAVE_SLOT,
	SELECTED_EXIT_GAME
	PROMPT_OVERWRITE,
	SELECTED_OVERWRITE_YES,
	SELECTED_OVERWRITE_NO,
	SAVE
}

var selector: int = 0
var state: int = STATES.ENTERED_ROOM
var initialDelay: float = 2.0
var selectedDelay: float = 0.2

var slot1Info = ""
var slot2Info = ""
var slot3Info = ""

func _delay(delay: float) -> void:
	$Delay.wait_time = delay
	$Delay.start()
	
func _saveGameOnSlot() -> void:
	var saveSlot = selector - 2
	IoHandler.saveGame(saveSlot)

func _setSelectorPosition() -> void:
	var selectorPosition = Vector2(0,0)
	if selector == 0:
		selectorPosition = Vector2(26,102)
	elif selector == 1:
		selectorPosition = Vector2(26,118)
	elif selector == 2:
		selectorPosition = Vector2(26,134)
	elif selector == 3:
		selectorPosition = Vector2(26,166)
	elif selector == 4:
		selectorPosition = Vector2(26,182)
	elif selector == 5:
		selectorPosition = Vector2(26,198)
		
	$Canvas/SelectorSprite.position = selectorPosition

func _getAnimationNameFromType(type : int) -> String:
	if type == Global.TAIL_TYPE.CLERIC:
		return "cleric"
	elif type == Global.TAIL_TYPE.DWARF:
		return "dwarf"
	elif type == Global.TAIL_TYPE.ELF:
		return "elf"
	elif type == Global.TAIL_TYPE.POOCH:
		return "pooch"
	elif type == Global.TAIL_TYPE.THIEF:
		return "thief"
	elif type == Global.TAIL_TYPE.WIZARD:
		return "wizard"
	return ""
	
func _loadSaveSlotInfo() -> void:
	slot1Info = IoHandler.getSaveSlotInfo(1)
	slot2Info = IoHandler.getSaveSlotInfo(2)
	slot3Info = IoHandler.getSaveSlotInfo(3)
	
func checkAndPromptOverWrite() -> void:
	var saveSlot = selector - 2
	if IoHandler.getSaveSlotEmpty(saveSlot):
		state = STATES.PROMPT_OVERWRITE
		_delay(selectedDelay)
	else:
		state = STATES.SELECTED_OVERWRITE_YES
		_delay(selectedDelay)

func _viewPlayer() -> void:
	if Global.saveGameData.weapon.tier3.equiped == true && Global.saveGameData.armor.tier3.equiped == true && Global.saveGameData.shield.tier3.equiped == true:
		$Canvas/PlayerSprite.play("tier3")
	elif Global.saveGameData.shield.tier2.equiped == true:
		$Canvas/PlayerSprite.play("tier2")
	else: 
		$Canvas/PlayerSprite.play("tier1")

func _viewPartyFromData() -> void:
	if Global.saveGameData.tail1.type == Global.TAIL_TYPE.NONE:
		$Canvas/Member1Sprite.hide()
	else:
		$Canvas/Member1Sprite.show()
	if Global.saveGameData.tail2.type == Global.TAIL_TYPE.NONE:
		$Canvas/Member2Sprite.hide()
	else:
		$Canvas/Member2Sprite.show()
	if Global.saveGameData.tail3.type == Global.TAIL_TYPE.NONE:
		$Canvas/Member3Sprite.hide()
	else:
		$Canvas/Member3Sprite.show()
	$Canvas/Member1Sprite.play(_getAnimationNameFromType(Global.saveGameData.tail1.type))
	$Canvas/Member2Sprite.play(_getAnimationNameFromType(Global.saveGameData.tail2.type))
	$Canvas/Member3Sprite.play(_getAnimationNameFromType(Global.saveGameData.tail3.type))

func _updateInterface() -> void:
	if state == STATES.ENTERED_ROOM:
		$Canvas/lblTitle.text = LanguageHandler.getText("lblHeader_Inn")
		$Canvas/lblDescription.text = LanguageHandler.getText("lblDescription_welcome")
		$Canvas/lblOption1.text = LanguageHandler.getText("lbl_empty")
		$Canvas/lblOption2.text = LanguageHandler.getText("lbl_empty")
		$Canvas/lblOption3.text = LanguageHandler.getText("lbl_empty")
		$Canvas/lblSaveSlot1.text = LanguageHandler.getText("lbl_empty")
		$Canvas/lblSaveSlot2.text = LanguageHandler.getText("lbl_empty")
		$Canvas/lblSaveSlot3.text = LanguageHandler.getText("lbl_empty")
		$Canvas/SelectorSprite.hide()
		
	if state == STATES.PROMPT_ACTION:
		$Canvas/lblTitle.text = LanguageHandler.getText("lblHeader_Inn")
		$Canvas/lblDescription.text = LanguageHandler.getText("lblDescription_save_game_prompt")
		$Canvas/lblOption1.text = LanguageHandler.getText("lblOption_save_game")
		$Canvas/lblOption2.text = LanguageHandler.getText("lblOption_leave")
		$Canvas/lblOption3.text = LanguageHandler.getText("lblOption_exit_game")
		$Canvas/lblSaveSlot1.text = LanguageHandler.getText("lbl_empty")
		$Canvas/lblSaveSlot2.text = LanguageHandler.getText("lbl_empty")
		$Canvas/lblSaveSlot3.text = LanguageHandler.getText("lbl_empty")
		$Canvas/SelectorSprite.show()
	
	if state == STATES.PROMPT_ACTION_SAVE:
		$Canvas/lblTitle.text = LanguageHandler.getText("lblHeader_Inn")
		$Canvas/lblDescription.text = LanguageHandler.getText("lblDescription_save_game_prompt")
		$Canvas/lblOption1.text = LanguageHandler.getText("lblOption_save_game")
		$Canvas/lblOption2.text = LanguageHandler.getText("lbl_empty")
		$Canvas/lblOption3.text = LanguageHandler.getText("lbl_empty")
		$Canvas/lblSaveSlot1.text = slot1Info
		$Canvas/lblSaveSlot2.text = slot2Info
		$Canvas/lblSaveSlot3.text = slot3Info
		$Canvas/SelectorSprite.show()
		
	if state == STATES.PROMPT_OVERWRITE:
		$Canvas/lblTitle.text = LanguageHandler.getText("lblHeader_Inn")
		$Canvas/lblDescription.text = LanguageHandler.getText("lblDescription_overwrite")
		$Canvas/lblOption1.text = LanguageHandler.getText("lbl_no")
		$Canvas/lblOption2.text = LanguageHandler.getText("lbl_yes")
		$Canvas/lblOption3.text = LanguageHandler.getText("lbl_empty")
		$Canvas/lblSaveSlot1.text = slot1Info
		$Canvas/lblSaveSlot2.text = slot2Info
		$Canvas/lblSaveSlot3.text = slot3Info
		$Canvas/SelectorSprite.show()
		
	
	_viewPlayer()
	_viewPartyFromData()
	
func _ready():
	Events.emit_signal("pressButtonIndicator", false)
	$Canvas/lblTitle.text = LanguageHandler.getText("lblHeader_Inn")
	_delay(initialDelay)

func _physics_process(delta):
	if state != STATES.ENTERED_ROOM:
		if Input.is_action_just_pressed("DOWN"):
			selector += 1
		if Input.is_action_just_pressed("UP"):
			selector -= 1
		
		if Input.is_action_just_pressed("JUMP"):
			if state == STATES.PROMPT_ACTION:
				state = STATES.SELECTED_EXIT_GAME
				_delay(selectedDelay)
			if state == STATES.PROMPT_ACTION_SAVE:
				selector = 0
				state = STATES.PROMPT_ACTION
				_delay(selectedDelay)
			
		if Input.is_action_just_pressed("ACTION_MAIN"):
			if state == STATES.PROMPT_ACTION:
				if selector == 0:
					state = STATES.SELECTED_ACTION_SAVE
					_delay(selectedDelay)
				if selector == 1:
					state = STATES.LEAVE_ROOM
					_delay(selectedDelay)
				if selector == 2:
					state = STATES.SELECTED_EXIT_GAME
					_delay(selectedDelay)
			if state == STATES.PROMPT_ACTION_SAVE:
				state = STATES.SELECTED_ACTION_SAVE_SLOT
				checkAndPromptOverWrite()
			if state == STATES.PROMPT_OVERWRITE:
				if selector == 0:
					state = STATES.SELECTED_OVERWRITE_NO
					_delay(selectedDelay)
				if selector == 1:
					state = STATES.SELECTED_OVERWRITE_YES
					_delay(selectedDelay)
					
				
		
	if selector < 0:
		selector = 0
	if state == STATES.PROMPT_ACTION:
		if selector > 2:
			selector = 2
	if state == STATES.PROMPT_ACTION_SAVE:
		if selector < 3:
			selector = 3
	if state == STATES.PROMPT_OVERWRITE:
		if selector > 1:
			selector = 1
	if selector > 5:
			selector = 5
	_setSelectorPosition()
	_updateInterface() 
	

func _on_Delay_timeout():
	if state == STATES.ENTERED_ROOM:
		state = STATES.PROMPT_ACTION
		Events.emit_signal("pressButtonIndicator", true)
	if state == STATES.SELECTED_ACTION_SAVE:
		_loadSaveSlotInfo()
		state = STATES.PROMPT_ACTION_SAVE
		selector = 3
		Events.emit_signal("pressButtonIndicator", true)
	if state == STATES.SELECTED_OVERWRITE_NO:
		state = STATES.PROMPT_ACTION
		Events.emit_signal("pressButtonIndicator", true)
	if state == STATES.SELECTED_OVERWRITE_YES:
		_saveGameOnSlot()
		selector = 0
		state = STATES.PROMPT_ACTION
		Events.emit_signal("pressButtonIndicator", true)
