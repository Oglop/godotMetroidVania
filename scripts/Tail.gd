extends Node2D

var positionInTail = 0
var tailNumber = 0
var type = Global.TAIL_TYPE.NONE

# Called when the node enters the scene tree for the first time.
func _ready():
	Events.connect("chargeTrigger", self, "_on_chargeTrigger")
	Events.connect("playerPressedAttack", self, "_on_PlayerPressedAttack")
	setTypeFromPositionInTail()
	
func setTypeFromPositionInTail():
	if tailNumber == 1:
		type = Global.saveGameData.tail1.type
	if tailNumber == 2:
		type = Global.saveGameData.tail2.type
	if tailNumber == 3:
		type = Global.saveGameData.tail3.type

func setPositionInTail(_position, _tailNumber):
	positionInTail = _position
	tailNumber = _tailNumber

func _on_PlayerPressedAttack():
	if type == Global.TAIL_TYPE.POOCH:
		pass
	elif type == Global.TAIL_TYPE.THIEF:
		Events.emit_signal("fireThiefKnifeProjectile", $onPosition.global_position, Global.TAIL_DIRECTION[positionInTail])
	elif type == Global.TAIL_TYPE.WIZARD:
		Events.emit_signal("fireWizardSpellProjectile", $onPosition.global_position, Global.TAIL_DIRECTION[positionInTail])
	elif type == Global.TAIL_TYPE.ELF:
		Events.emit_signal("fireElfArrow", $onPosition.global_position, Global.TAIL_DIRECTION[positionInTail])
	elif type == Global.TAIL_TYPE.DWARF:
		Events.emit_signal("fireDwarfAxeProjectile", $onPosition.global_position, Global.TAIL_DIRECTION[positionInTail])

func _on_chargeTrigger():
	if type == Global.TAIL_TYPE.POOCH:
		pass
	elif type == Global.TAIL_TYPE.THIEF:
		pass
	elif type == Global.TAIL_TYPE.WIZARD:
		pass
	elif type == Global.TAIL_TYPE.ELF:
		pass
	elif type == Global.TAIL_TYPE.DWARF:
		if Global.saveGameData.inventory.bomb.found == true:
			Events.emit_signal("tailBombDrop", self.position.x, self.position.y)

func setAnimationFromType():
	if type == Global.TAIL_TYPE.NONE:
		$TailSprite.hide()
	else:
		$TailSprite.show()
		
	if Global.playerState == Global.PLAYER_STATE.ATTACK:
		if type == Global.TAIL_TYPE.POOCH:
			$TailSprite.play("poochAttack")
		elif type == Global.TAIL_TYPE.THIEF:
			$TailSprite.play("thiefAttack")
		elif type == Global.TAIL_TYPE.WIZARD:
			$TailSprite.play("wizardAttack")
		elif type == Global.TAIL_TYPE.ELF:
			$TailSprite.play("elfAttack")
		elif type == Global.TAIL_TYPE.DWARF:
			$TailSprite.play("dwarfAttack")
	else:
		if Global.TAIL_ANIMATION[positionInTail] == Global.PLAYER_STATE.IDLE:
			if type == Global.TAIL_TYPE.POOCH:
				$TailSprite.play("poochIdle")
			elif type == Global.TAIL_TYPE.THIEF:
				$TailSprite.play("thiefIdle")
			elif type == Global.TAIL_TYPE.WIZARD:
				$TailSprite.play("wizardIdle")
			elif type == Global.TAIL_TYPE.ELF:
				$TailSprite.play("elfIdle")
			elif type == Global.TAIL_TYPE.DWARF:
				$TailSprite.play("dwarfIdle")
			
		elif Global.TAIL_ANIMATION[positionInTail] == Global.PLAYER_STATE.WALKING:
			if type == Global.TAIL_TYPE.POOCH:
				$TailSprite.play("poochWalking")
			elif type == Global.TAIL_TYPE.THIEF:
				$TailSprite.play("thiefWalking")
			elif type == Global.TAIL_TYPE.WIZARD:
				$TailSprite.play("wizardWalking")
			elif type == Global.TAIL_TYPE.ELF:
				$TailSprite.play("elfWalking")
			elif type == Global.TAIL_TYPE.DWARF:
				$TailSprite.play("dwarfWalking")
				
		elif Global.TAIL_ANIMATION[positionInTail] == Global.PLAYER_STATE.AIR:
			if type == Global.TAIL_TYPE.POOCH:
				$TailSprite.play("poochAir")
			elif type == Global.TAIL_TYPE.THIEF:
				$TailSprite.play("thiefAir")
			elif type == Global.TAIL_TYPE.WIZARD:
				$TailSprite.play("wizardAir")
			elif type == Global.TAIL_TYPE.ELF:
				$TailSprite.play("elfAir")
			elif type == Global.TAIL_TYPE.DWARF:
				$TailSprite.play("dwarfAir")
	
func _physics_process(delta):
	if Global.playerState != Global.PLAYER_STATE.IDLE:
		self.position = Vector2(Global.X_POSITIONS[positionInTail], Global.Y_POSITIONS[positionInTail])
		$TailSprite.flip_h = Global.TAIL_DIRECTION[positionInTail]
	setAnimationFromType()
