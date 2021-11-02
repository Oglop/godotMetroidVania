extends KinematicBody2D

onready var floorChecker = get_node("PlayerFloorDetector")
onready var rightDamagePoint = get_node("RightHurtPoint")
onready var leftDamagePoint = get_node("LeftHurtPoint")

var velocity = Vector2(0,0)
var speedIncrease = 5;


func setPosition(x, y):
	self.position.x = x
	self.position.y = y
# Called when the node enters the scene tree for the first time.
func _ready():
	for n in range(Global.TAIL_SIZE,-1,-1):
		Global.X_POSITIONS[n] = self.position.x
		Global.Y_POSITIONS[n] = self.position.y
		Global.TAIL_DIRECTION[n] = $PlayerSprite.flip_h
		Global.TAIL_ANIMATION[n] = Global.playerState
		
	createMap()
		
func setAnimationFromState():
	if Global.playerState == Global.PLAYER_STATE.WALKING:
		$PlayerSprite.play("walk")
	elif Global.playerState == Global.PLAYER_STATE.AIR:
		$PlayerSprite.play("air")
	else:
		$PlayerSprite.play("idle")
	
func createMap():
	if Data.map.size() == 0:
		for y in range(0, 100):
			var array = []
			for x in range(0, 100):
				array.append(0)
			Data.map.append(array)
	
# getHoriVelocity(Global.DIRECTIONS.RIGHT)
# getHoriVelocity(Global.DIRECTIONS.LEFT)
func getHoriVelocity(direction):
	var currentSpeed = 0;
	if direction == Global.DIRECTIONS.RIGHT:
		if velocity.x + speedIncrease < Global.HORI_SPEED:
			currentSpeed = velocity.x + speedIncrease
		else: 
			currentSpeed = Global.HORI_SPEED
	if direction == Global.DIRECTIONS.LEFT:
		if velocity.x - speedIncrease > Global.HORI_SPEED * -1:
			currentSpeed = velocity.x - speedIncrease
		else: 
			currentSpeed = -Global.HORI_SPEED
	return currentSpeed
			

func checkPositionOnMap():
	var currentMapX = (self.position.x / Global.SCREEN_SIZE_X) + Global.mapOffestX
	var currentMapY = (self.position.y / Global.SCREEN_SIZE_Y) + Global.mapOffsetY
	Data.map[currentMapX][currentMapY] = 1

func _physics_process(delta):
	if Input.is_action_pressed("RIGHT"):
		velocity.x = Global.HORI_SPEED
		$PlayerSprite.flip_h = false
		Global.playerState = Global.PLAYER_STATE.WALKING
	elif Input.is_action_pressed("LEFT"): 
		velocity.x = -Global.HORI_SPEED
		$PlayerSprite.flip_h = true
		Global.playerState = Global.PLAYER_STATE.WALKING
	else:
		Global.playerState = Global.PLAYER_STATE.IDLE
	if not self.is_on_floor():
		Global.playerState = Global.PLAYER_STATE.AIR
		
	velocity.y += Global.GRAVITY
	if Global.playerState != Global.PLAYER_STATE.IDLE:
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
		
	if Input.is_action_just_pressed("JUMP") && self.is_on_floor():
		velocity.y = Global.JUMP_STRENGTH
	
	#if !Input.is_action_pressed("RIGHT") && Input.is_action_pressed("LEFT"):
	#	currentSpeed = lerp(currentSpeed, 0, Global.HORI_STOP)
	
	velocity = self.move_and_slide(velocity, Vector2.UP)
	#currentSpeed = lerp(velocity.x, 0, Global.HORI_STOP)
	velocity.x = lerp(velocity.x, 0, Global.HORI_STOP)
	
	setAnimationFromState()
	checkPositionOnMap()
