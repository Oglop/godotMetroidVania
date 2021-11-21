extends Node2D


enum ROOM_STATES {
	ROOM_ENTERED,
	CHOOSE_CHANGE_OR_EXIT,
	SELECTED_YES,
	SELECTED_NO,
	SELECTED_FIRST_OPTION,
	SELECTED_SECOND_OPTION
	SELECTED_THIRD_OPTION
	CHOOSE_FIRST_MEMBER,
	CHOOSE_SECOND_MEMBER,
	CHOOSE_THIRD_MEMBER,
	CHOOSE_PROMPT_ACCEPT_PARTY,
	SELECTED_ACCEPT_NEW_PARTY,
	SELECTED_REJECT_NEW_PARTY,
	LEAVING_ROOM
}

var selectedMembers = {
	"position1": Global.TAIL_TYPE.NONE,
	"position2": Global.TAIL_TYPE.NONE,
	"position3": Global.TAIL_TYPE.NONE
}

var freeMembers = []
var initialDelay = 3.0
var selectedDelay = 0.2
var state = ROOM_STATES.ROOM_ENTERED
var previousRoom = ""
var selector = 0

func _isMemberSelected(tailType: int) -> bool:
	if selectedMembers.position1 == tailType || selectedMembers.position2 == tailType || selectedMembers.position3 == tailType:
		return true
	return false

func _selectedMembersToSavedGameData() -> void:
	Global.saveGameData.tail1.type = selectedMembers.position1
	Global.saveGameData.tail2.type = selectedMembers.position2
	Global.saveGameData.tail3.type = selectedMembers.position3
	selectedMembers = {
		"position1": Global.TAIL_TYPE.NONE,
		"position2": Global.TAIL_TYPE.NONE,
		"position3": Global.TAIL_TYPE.NONE
	}
	
func _getMemberAtSelector() -> int:
	return freeMembers[selector]
	
func _setSelectedMembers() -> void:
	selectedMembers.position1 = Global.TAIL_TYPE.NONE
	selectedMembers.position2 = Global.TAIL_TYPE.NONE
	selectedMembers.position3 = Global.TAIL_TYPE.NONE

func _setFreeMembers() -> void:
	freeMembers = []
	selector = 0
	
	if !_isMemberSelected(Global.TAIL_TYPE.POOCH):
		freeMembers.push_back(Global.TAIL_TYPE.POOCH)
	if !_isMemberSelected(Global.TAIL_TYPE.THIEF):
		freeMembers.push_back(Global.TAIL_TYPE.THIEF)
	if !_isMemberSelected(Global.TAIL_TYPE.CLERIC):
		freeMembers.push_back(Global.TAIL_TYPE.CLERIC)
	if !_isMemberSelected(Global.TAIL_TYPE.DWARF):
		freeMembers.push_back(Global.TAIL_TYPE.DWARF)
	if !_isMemberSelected(Global.TAIL_TYPE.ELF):
		freeMembers.push_back(Global.TAIL_TYPE.ELF)
	if !_isMemberSelected(Global.TAIL_TYPE.WIZARD):
		freeMembers.push_back(Global.TAIL_TYPE.WIZARD)
		
func _resetSelectedmembers() -> void:
	selectedMembers = {
		"position1": Global.TAIL_TYPE.NONE,
		"position2": Global.TAIL_TYPE.NONE,
		"position3": Global.TAIL_TYPE.NONE
	}
		
func _getFreeMember(index: int) -> String:
	if freeMembers[index] == Global.TAIL_TYPE.POOCH:
		return LanguageHandler.getText("lblOption_pooch_name")
	if freeMembers[index] == Global.TAIL_TYPE.THIEF:
		return LanguageHandler.getText("lblOption_thief_name")
	if freeMembers[index] == Global.TAIL_TYPE.CLERIC:
		return LanguageHandler.getText("lblOption_cleric_name")
	if freeMembers[index] == Global.TAIL_TYPE.DWARF:
		return LanguageHandler.getText("lblOption_dwarf_name")
	if freeMembers[index] == Global.TAIL_TYPE.ELF:
		return LanguageHandler.getText("lblOption_elf_name")
	if freeMembers[index] == Global.TAIL_TYPE.WIZARD:
		return LanguageHandler.getText("lblOption_wizard_name")
	else:
		return LanguageHandler.getText("lbl_empty")

func _updateInterface() -> void:
	if state == ROOM_STATES.ROOM_ENTERED:
		$CanvasLayer/lblHeader.text = LanguageHandler.getText("lblHeader_welcome")
		$CanvasLayer/lblDescription.text = LanguageHandler.getText("lbl_empty")
		$CanvasLayer/lblOption1.text = LanguageHandler.getText("lbl_empty")
		$CanvasLayer/lblOption2.text = LanguageHandler.getText("lbl_empty")
		$CanvasLayer/lblOption3.text = LanguageHandler.getText("lbl_empty")
		$CanvasLayer/lblOption4.text = LanguageHandler.getText("lbl_empty")
		$CanvasLayer/lblOption5.text = LanguageHandler.getText("lbl_empty")
		$CanvasLayer/lblOption6.text = LanguageHandler.getText("lbl_empty")
		$CanvasLayer/Selector.hide()
		_viewPartyFromData()
	if state == ROOM_STATES.CHOOSE_CHANGE_OR_EXIT:
		$CanvasLayer/lblHeader.text = LanguageHandler.getText("lblHeader_guild")
		$CanvasLayer/lblDescription.text = LanguageHandler.getText("lblDescription_chose_new_members")
		$CanvasLayer/lblOption1.text = LanguageHandler.getText("lbl_no")
		$CanvasLayer/lblOption2.text = LanguageHandler.getText("lbl_yes")
		$CanvasLayer/lblOption3.text = LanguageHandler.getText("lbl_empty")
		$CanvasLayer/lblOption4.text = LanguageHandler.getText("lbl_empty")
		$CanvasLayer/lblOption5.text = LanguageHandler.getText("lbl_empty")
		$CanvasLayer/lblOption6.text = LanguageHandler.getText("lbl_empty")
		$CanvasLayer/Selector.show()
		_viewPartyFromData()
	if state == ROOM_STATES.SELECTED_NO:
		$CanvasLayer/lblHeader.text = LanguageHandler.getText("lblHeader_guild")
		$CanvasLayer/lblDescription.text = LanguageHandler.getText("lblDescription_leaving")
		$CanvasLayer/lblOption1.text = LanguageHandler.getText("lbl_no")
		$CanvasLayer/lblOption2.text = LanguageHandler.getText("lbl_empty")
		$CanvasLayer/lblOption3.text = LanguageHandler.getText("lbl_empty")
		$CanvasLayer/lblOption4.text = LanguageHandler.getText("lbl_empty")
		$CanvasLayer/lblOption5.text = LanguageHandler.getText("lbl_empty")
		$CanvasLayer/lblOption6.text = LanguageHandler.getText("lbl_empty")
		$CanvasLayer/Selector.hide()
		_viewPartyFromData()
	if state == ROOM_STATES.SELECTED_YES:
		$CanvasLayer/lblHeader.text = LanguageHandler.getText("lblHeader_guild")
		$CanvasLayer/lblDescription.text = LanguageHandler.getText("lbl_empty")
		$CanvasLayer/lblOption1.text = LanguageHandler.getText("lbl_empty")
		$CanvasLayer/lblOption2.text = LanguageHandler.getText("lbl_yes")
		$CanvasLayer/lblOption3.text = LanguageHandler.getText("lbl_empty")
		$CanvasLayer/lblOption4.text = LanguageHandler.getText("lbl_empty")
		$CanvasLayer/lblOption5.text = LanguageHandler.getText("lbl_empty")
		$CanvasLayer/lblOption6.text = LanguageHandler.getText("lbl_empty")
		$CanvasLayer/Member1Sprite.hide()
		$CanvasLayer/Member2Sprite.hide()
		$CanvasLayer/Member3Sprite.hide()
		_viewPartyFromSelection(99)
		$CanvasLayer/Selector.hide()
	if state == ROOM_STATES.CHOOSE_FIRST_MEMBER:
		$CanvasLayer/lblHeader.text = LanguageHandler.getText("lblHeader_guild")
		$CanvasLayer/lblDescription.text = LanguageHandler.getText("lblDescription_select_party_member")
		$CanvasLayer/lblOption1.text = _getFreeMember(0)
		$CanvasLayer/lblOption2.text = _getFreeMember(1)
		$CanvasLayer/lblOption3.text = _getFreeMember(2)
		$CanvasLayer/lblOption4.text = _getFreeMember(3)
		$CanvasLayer/lblOption5.text = _getFreeMember(4)
		$CanvasLayer/lblOption6.text = _getFreeMember(5)
		$CanvasLayer/Member1Sprite.show()
		$CanvasLayer/Member2Sprite.hide()
		$CanvasLayer/Member3Sprite.hide()
		_viewPartyFromSelection(0)
		$CanvasLayer/Selector.show()
	if state == ROOM_STATES.SELECTED_FIRST_OPTION:
		$CanvasLayer/lblHeader.text = LanguageHandler.getText("lblHeader_guild")
		$CanvasLayer/lblDescription.text = LanguageHandler.getText("lblDescription_select_party_member")
		$CanvasLayer/lblOption1.text = LanguageHandler.getText("lbl_empty")
		$CanvasLayer/lblOption2.text = LanguageHandler.getText("lbl_empty")
		$CanvasLayer/lblOption3.text = LanguageHandler.getText("lbl_empty")
		$CanvasLayer/lblOption4.text = LanguageHandler.getText("lbl_empty")
		$CanvasLayer/lblOption5.text = LanguageHandler.getText("lbl_empty")
		$CanvasLayer/lblOption6.text = LanguageHandler.getText("lbl_empty")
		$CanvasLayer/Member1Sprite.show()
		$CanvasLayer/Member2Sprite.hide()
		$CanvasLayer/Member3Sprite.hide()
		_viewPartyFromSelection(99)
		$CanvasLayer/Selector.hide()
	if state == ROOM_STATES.CHOOSE_SECOND_MEMBER:
		$CanvasLayer/lblHeader.text = LanguageHandler.getText("lblHeader_guild")
		$CanvasLayer/lblDescription.text = LanguageHandler.getText("lblDescription_select_party_member")
		$CanvasLayer/lblOption1.text = _getFreeMember(0)
		$CanvasLayer/lblOption2.text = _getFreeMember(1)
		$CanvasLayer/lblOption3.text = _getFreeMember(2)
		$CanvasLayer/lblOption4.text = _getFreeMember(3)
		$CanvasLayer/lblOption5.text = _getFreeMember(4)
		$CanvasLayer/lblOption6.text = LanguageHandler.getText("lbl_empty")
		$CanvasLayer/Member1Sprite.show()
		$CanvasLayer/Member2Sprite.show()
		$CanvasLayer/Member3Sprite.hide()
		_viewPartyFromSelection(1)
		$CanvasLayer/Selector.show()
	if state == ROOM_STATES.SELECTED_SECOND_OPTION:
		$CanvasLayer/lblHeader.text = LanguageHandler.getText("lblHeader_guild")
		$CanvasLayer/lblDescription.text = LanguageHandler.getText("lblDescription_select_party_member")
		$CanvasLayer/lblOption1.text = LanguageHandler.getText("lbl_empty")
		$CanvasLayer/lblOption2.text = LanguageHandler.getText("lbl_empty")
		$CanvasLayer/lblOption3.text = LanguageHandler.getText("lbl_empty")
		$CanvasLayer/lblOption4.text = LanguageHandler.getText("lbl_empty")
		$CanvasLayer/lblOption5.text = LanguageHandler.getText("lbl_empty")
		$CanvasLayer/lblOption6.text = LanguageHandler.getText("lbl_empty")
		$CanvasLayer/Member1Sprite.show()
		$CanvasLayer/Member2Sprite.show()
		$CanvasLayer/Member3Sprite.hide()
		_viewPartyFromSelection(99)
		$CanvasLayer/Selector.hide()
	if state == ROOM_STATES.CHOOSE_THIRD_MEMBER:
		$CanvasLayer/lblHeader.text = LanguageHandler.getText("lblHeader_guild")
		$CanvasLayer/lblDescription.text = LanguageHandler.getText("lblDescription_select_party_member")
		$CanvasLayer/lblOption1.text = _getFreeMember(0)
		$CanvasLayer/lblOption2.text = _getFreeMember(1)
		$CanvasLayer/lblOption3.text = _getFreeMember(2)
		$CanvasLayer/lblOption4.text = _getFreeMember(3)
		$CanvasLayer/lblOption5.text = LanguageHandler.getText("lbl_empty")
		$CanvasLayer/lblOption6.text = LanguageHandler.getText("lbl_empty")
		$CanvasLayer/Member1Sprite.show()
		$CanvasLayer/Member2Sprite.show()
		$CanvasLayer/Member3Sprite.show()
		_viewPartyFromSelection(2)
		$CanvasLayer/Selector.show()
	if state == ROOM_STATES.SELECTED_THIRD_OPTION:
		$CanvasLayer/lblHeader.text = LanguageHandler.getText("lblHeader_guild")
		$CanvasLayer/lblDescription.text = LanguageHandler.getText("lbl_empty")
		$CanvasLayer/lblOption1.text = LanguageHandler.getText("lbl_empty")
		$CanvasLayer/lblOption2.text = LanguageHandler.getText("lbl_empty")
		$CanvasLayer/lblOption3.text = LanguageHandler.getText("lbl_empty")
		$CanvasLayer/lblOption4.text = LanguageHandler.getText("lbl_empty")
		$CanvasLayer/lblOption5.text = LanguageHandler.getText("lbl_empty")
		$CanvasLayer/lblOption6.text = LanguageHandler.getText("lbl_empty")
		$CanvasLayer/Member1Sprite.show()
		$CanvasLayer/Member2Sprite.show()
		$CanvasLayer/Member3Sprite.show()
		_viewPartyFromSelection(99)
		$CanvasLayer/Selector.hide()
	if state == ROOM_STATES.CHOOSE_PROMPT_ACCEPT_PARTY:
		$CanvasLayer/lblHeader.text = LanguageHandler.getText("lblHeader_guild")
		$CanvasLayer/lblDescription.text = LanguageHandler.getText("lblDescription_accept_new_party_prompt")
		$CanvasLayer/lblOption1.text = LanguageHandler.getText("lbl_yes")
		$CanvasLayer/lblOption2.text = LanguageHandler.getText("lbl_no")
		$CanvasLayer/lblOption3.text = LanguageHandler.getText("lbl_empty")
		$CanvasLayer/lblOption4.text = LanguageHandler.getText("lbl_empty")
		$CanvasLayer/lblOption5.text = LanguageHandler.getText("lbl_empty")
		$CanvasLayer/lblOption6.text = LanguageHandler.getText("lbl_empty")
		$CanvasLayer/Member1Sprite.show()
		$CanvasLayer/Member2Sprite.show()
		$CanvasLayer/Member3Sprite.show()
		_viewPartyFromSelection(99)
		$CanvasLayer/Selector.show()

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

func _viewPlayer() -> void:
	if Global.saveGameData.weapon.tier3.equiped == true && Global.saveGameData.armor.tier3.equiped == true && Global.saveGameData.shield.tier3.equiped == true:
		$CanvasLayer/PlayerSprite.play("tier3")
	elif Global.saveGameData.shield.tier2.equiped == true:
		$CanvasLayer/PlayerSprite.play("tier2")
	else: 
		$CanvasLayer/PlayerSprite.play("tier1")

func _viewPartyFromData() -> void:
	if Global.saveGameData.tail1.type == Global.TAIL_TYPE.NONE:
		$CanvasLayer/Member1Sprite.hide()
	else:
		$CanvasLayer/Member1Sprite.show()
	if Global.saveGameData.tail2.type == Global.TAIL_TYPE.NONE:
		$CanvasLayer/Member2Sprite.hide()
	else:
		$CanvasLayer/Member2Sprite.show()
	if Global.saveGameData.tail3.type == Global.TAIL_TYPE.NONE:
		$CanvasLayer/Member3Sprite.hide()
	else:
		$CanvasLayer/Member3Sprite.show()
	$CanvasLayer/Member1Sprite.play(_getAnimationNameFromType(Global.saveGameData.tail1.type))
	$CanvasLayer/Member2Sprite.play(_getAnimationNameFromType(Global.saveGameData.tail2.type))
	$CanvasLayer/Member3Sprite.play(_getAnimationNameFromType(Global.saveGameData.tail3.type))

func _viewPartyFromSelection(selected: int) -> void:
	if selected == 0:
		$CanvasLayer/Member1Sprite.play(_getAnimationNameFromType(_getMemberAtSelector()))
	if selected == 1:
		$CanvasLayer/Member1Sprite.play(_getAnimationNameFromType(selectedMembers.position1))
		$CanvasLayer/Member2Sprite.play(_getAnimationNameFromType(_getMemberAtSelector()))

	if selected == 2:
		$CanvasLayer/Member1Sprite.play(_getAnimationNameFromType(selectedMembers.position1))
		$CanvasLayer/Member2Sprite.play(_getAnimationNameFromType(selectedMembers.position2))
		$CanvasLayer/Member3Sprite.play(_getAnimationNameFromType(_getMemberAtSelector()))
	if selected == 99:
		$CanvasLayer/Member1Sprite.play(_getAnimationNameFromType(selectedMembers.position1))
		$CanvasLayer/Member2Sprite.play(_getAnimationNameFromType(selectedMembers.position2))
		$CanvasLayer/Member3Sprite.play(_getAnimationNameFromType(selectedMembers.position3))

func _updateSelectorPosition() -> void:
	var selectorPosition = Vector2(0,0)
	if selector == 0:
		selectorPosition = Vector2(26, 102)
	elif selector == 1:
		selectorPosition = Vector2(26, 118)
	elif selector == 2:
		selectorPosition = Vector2(26, 134)
	elif selector == 3:
		selectorPosition = Vector2(26, 150)
	elif selector == 4:
		selectorPosition = Vector2(26, 166)
	elif selector == 5:
		selectorPosition = Vector2(26, 182)
		
	$CanvasLayer/Selector.position = selectorPosition

func _delayAction(time: float) -> void:
	$Delay.wait_time = time
	$Delay.start()

func _ready():
	Events.emit_signal("pressButtonIndicator", false)
	self._delayAction(initialDelay)
	
func _transferToWorld():
	Events.emit_signal("transitionToRoom",  Global.PREVIOUS_ROOM, 0, 0)

func _physics_process(delta):
	if state != ROOM_STATES.ROOM_ENTERED && state != ROOM_STATES.SELECTED_NO && state != ROOM_STATES.SELECTED_YES && state != ROOM_STATES.SELECTED_FIRST_OPTION && state != ROOM_STATES.SELECTED_SECOND_OPTION && state != ROOM_STATES.SELECTED_THIRD_OPTION && state != ROOM_STATES.LEAVING_ROOM:
		if Input.is_action_just_pressed("DOWN"):
			selector += 1
		if Input.is_action_just_pressed("UP"):
			selector -= 1
		if Input.is_action_just_pressed("ACTION_MAIN"):
			if state == ROOM_STATES.CHOOSE_CHANGE_OR_EXIT:
				if selector == 0:
					#go back to world
					state = ROOM_STATES.LEAVING_ROOM
					self._delayAction(selectedDelay)
					Events.emit_signal("pressButtonIndicator", false)
				elif selector == 1:
					#enter member selection loop
					state = ROOM_STATES.SELECTED_YES
					self._delayAction(selectedDelay)
					Events.emit_signal("pressButtonIndicator", false)
			if state == ROOM_STATES.CHOOSE_FIRST_MEMBER:
				state = ROOM_STATES.SELECTED_FIRST_OPTION
				selectedMembers.position1 = _getMemberAtSelector()
				Events.emit_signal("pressButtonIndicator", false)
				self._delayAction(selectedDelay)
			if state == ROOM_STATES.CHOOSE_SECOND_MEMBER:
				state = ROOM_STATES.SELECTED_SECOND_OPTION
				selectedMembers.position2 = _getMemberAtSelector()
				Events.emit_signal("pressButtonIndicator", false)
				self._delayAction(selectedDelay)
			if state == ROOM_STATES.CHOOSE_THIRD_MEMBER:
				state = ROOM_STATES.SELECTED_THIRD_OPTION
				selectedMembers.position3 = _getMemberAtSelector()
				Events.emit_signal("pressButtonIndicator", false)
				self._delayAction(selectedDelay)
			if state == ROOM_STATES.CHOOSE_PROMPT_ACCEPT_PARTY:
				if selector == 0:
					state = ROOM_STATES.SELECTED_ACCEPT_NEW_PARTY
					self._delayAction(selectedDelay)
					Events.emit_signal("pressButtonIndicator", false)
				elif selector == 1:
					state = ROOM_STATES.SELECTED_REJECT_NEW_PARTY
					self._delayAction(selectedDelay)
					Events.emit_signal("pressButtonIndicator", false)
		if Input.is_action_just_pressed("JUMP"):
			state = ROOM_STATES.LEAVING_ROOM
			self._delayAction(selectedDelay)
			Events.emit_signal("pressButtonIndicator", false)
				
	if selector < 0:
		selector = 0
	if state == ROOM_STATES.CHOOSE_CHANGE_OR_EXIT || state == ROOM_STATES.CHOOSE_PROMPT_ACCEPT_PARTY:
		if selector > 1:
			selector = 1
	if state == ROOM_STATES.CHOOSE_FIRST_MEMBER:
		if selector > 5:
			selector = 5
	if state == ROOM_STATES.CHOOSE_SECOND_MEMBER:
		if selector > 4:
			selector = 4
	if state == ROOM_STATES.CHOOSE_THIRD_MEMBER:
		if selector > 3:
			selector = 3
		
	_updateInterface()
	_viewPlayer()
	_updateSelectorPosition()
	
	

func _on_Delay_timeout():
	if state == ROOM_STATES.ROOM_ENTERED:
		Events.emit_signal("pressButtonIndicator", true)
		state = ROOM_STATES.CHOOSE_CHANGE_OR_EXIT
	if state == ROOM_STATES.SELECTED_YES:
		Events.emit_signal("pressButtonIndicator", true)
		state = ROOM_STATES.CHOOSE_FIRST_MEMBER
		_setSelectedMembers()
		_setFreeMembers()
	if state == ROOM_STATES.SELECTED_NO:
		Events.emit_signal("pressButtonIndicator", false)
		state = ROOM_STATES.LEAVING_ROOM
		_transferToWorld()
	if state == ROOM_STATES.SELECTED_FIRST_OPTION:
		Events.emit_signal("pressButtonIndicator", true)
		state = ROOM_STATES.CHOOSE_SECOND_MEMBER
		_setFreeMembers()
	if state == ROOM_STATES.SELECTED_SECOND_OPTION:
		Events.emit_signal("pressButtonIndicator", true)
		state = ROOM_STATES.CHOOSE_THIRD_MEMBER
		_setFreeMembers()
	if state == ROOM_STATES.SELECTED_THIRD_OPTION:
		selector = 0
		Events.emit_signal("pressButtonIndicator", true)
		state = ROOM_STATES.CHOOSE_PROMPT_ACCEPT_PARTY
	if state == ROOM_STATES.SELECTED_ACCEPT_NEW_PARTY:
		selector = 0
		_selectedMembersToSavedGameData()
		state = ROOM_STATES.CHOOSE_CHANGE_OR_EXIT
	if state == ROOM_STATES.SELECTED_REJECT_NEW_PARTY:
		selector = 0
		_resetSelectedmembers()
		state = ROOM_STATES.CHOOSE_CHANGE_OR_EXIT
	if state == ROOM_STATES.LEAVING_ROOM:
		_transferToWorld()


