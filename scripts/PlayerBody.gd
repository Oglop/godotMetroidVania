extends KinematicBody2D

onready var floorChecker = get_node("PlayerFloorDetector")
onready var rightDamagePoint = get_node("RightHurtPoint")
onready var leftDamagePoint = get_node("LeftHurtPoint")

var velocity = Vector2(0,0)
var speedIncrease = 5;


func setPosition(x, y):
	self.position.x = x
	self.position.y = y


func _ready():
	Events.connect("chargeTrigger", self, "_on_chargeTrigger")
	Events.connect("playerAnimationFinished", self, "_on_playerAnimationFinished")
	for n in range(Global.TAIL_SIZE,-1,-1):
		Global.X_POSITIONS[n] = self.position.x
		Global.Y_POSITIONS[n] = self.position.y
		Global.TAIL_DIRECTION[n] = $PlayerSprite.flip_h
		Global.TAIL_ANIMATION[n] = Global.playerState
		
	createMap()


		
func setAnimationFromState() -> void:
	if Global.playerState == Global.PLAYER_STATE.WALKING:
		$PlayerSprite.play("lv1Walking")
	elif Global.playerState == Global.PLAYER_STATE.AIR:
		$PlayerSprite.play("lv1Air")
	elif Global.playerState == Global.PLAYER_STATE.ATTACK:
		$PlayerSprite.play("lv1Attack")
	else:
		$PlayerSprite.play("lv1Idle")
	
func createMap() -> void:
	if Data.map.size() == 0:
		for y in range(0, 100):
			var array = []
			for x in range(0, 100):
				array.append(0)
			Data.map.append(array)


func _on_chargeTrigger():
	pass
	
func _on_playerAnimationFinished(animation) -> void:
	if animation == "lv1Attack":
		Global.playerState = Global.PLAYER_STATE.IDLE

func checkPositionOnMap():
	var currentMapX = (self.position.x / Global.SCREEN_SIZE_X) + Global.mapOffestX
	var currentMapY = (self.position.y / Global.SCREEN_SIZE_Y) + Global.mapOffsetY
	Data.map[currentMapX][currentMapY] = 1

func _physics_process(delta):
	if Global.playerState == Global.PLAYER_STATE.GO_THROUGH_DOOR:
		return
	
	if Global.playerState != Global.PLAYER_STATE.ATTACK:
		if Input.is_action_just_pressed("ACTION_MAIN"):
			Events.emit_signal("playerPressedAttack", $OnBodyPoint.global_position, $PlayerSprite.flip_h)
			#Global.playerState = Global.PLAYER_STATE.ATTACK
			
	if Global.playerState != Global.PLAYER_STATE.ATTACK || !self.is_on_floor():
		if Input.is_action_pressed("RIGHT"):
			velocity.x = Global.HORI_SPEED #clamp(velocity.x, 0, Global.HORI_SPEED)
			$PlayerSprite.flip_h = false
			Global.playerState = Global.PLAYER_STATE.WALKING
		elif Input.is_action_pressed("LEFT"): 
			velocity.x = -Global.HORI_SPEED
			$PlayerSprite.flip_h = true
			Global.playerState = Global.PLAYER_STATE.WALKING
		else:
			Global.playerState = Global.PLAYER_STATE.IDLE
		if not self.is_on_floor():# && Global.playerState != Global.PLAYER_STATE.ATTACK:
			Global.playerState = Global.PLAYER_STATE.AIR
		
	velocity.y += Global.GRAVITY
	if Global.playerState != Global.PLAYER_STATE.IDLE && Global.playerState != Global.PLAYER_STATE.ATTACK:
		if velocity.x != 0 || velocity.y != 0:
			for n in range(Global.TAIL_SIZE, 0, -1):
				Global.X_POSITIONS[n] = Global.X_POSITIONS[n - 1]
				Global.Y_POSITIONS[n] = Global.Y_POSITIONS[n - 1] 
				Global.TAIL_DIRECTION[n] = Global.TAIL_DIRECTION[n - 1]
				Global.TAIL_ANIMATION[n] = Global.TAIL_ANIMATION[n - 1]
			Global.X_POSITIONS[0] = self.position.x
			Global.Y_POSITIONS[0] = self.position.y
			Global.TAIL_ANIMATION[0] = Global.playerState
			Global.TAIL_DIRECTION[0] = $PlayerSprite.flip_h
		
	if Input.is_action_just_pressed("JUMP") && self.is_on_floor():# && Global.playerState != Global.PLAYER_STATE.ATTACK:
		velocity.y = Global.JUMP_STRENGTH
	
	velocity = self.move_and_slide(velocity, Vector2.UP)
	#currentSpeed = lerp(velocity.x, 0, Global.HORI_STOP)
	velocity.x = lerp(velocity.x, 0, Global.HORI_STOP)
	
	setAnimationFromState()
	checkPositionOnMap()
