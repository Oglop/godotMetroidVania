extends KinematicBody2D

onready var floorChecker = get_node("PlayerFloorDetector")
var velocity = Vector2(0,0)

var startPositionX = 0
var startPositionY = 0


func setPosition(x, y):
	startPositionX = x
	startPositionY = y
# Called when the node enters the scene tree for the first time.
func _ready():
	for n in range(Global.TAIL_SIZE,-1,-1):
		Global.X_POSITIONS[n] = startPositionX
		Global.Y_POSITIONS[n] = startPositionY
		
func setAnimationFromState():
	if Global.playerState == Global.PLAYER_STATE.WALKING:
		$PlayerSprite.play("walk")
	elif Global.playerState == Global.PLAYER_STATE.AIR:
		$PlayerSprite.play("jump")
	else:
		$PlayerSprite.play("idle")
	

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
				Global.TAIL_ANIMATION[n] = Global.TAIL_DIRECTION[n - 1]
			Global.X_POSITIONS[0] = self.position.x
			Global.Y_POSITIONS[0] = self.position.y
			Global.TAIL_ANIMATION[0] = Global.playerState
			Global.TAIL_DIRECTION[0] = $PlayerSprite.flip_h
		
	if Input.is_action_just_pressed("JUMP") && self.is_on_floor():
		velocity.y = Global.JUMP_STRENGTH
	
	velocity = self.move_and_slide(velocity, Vector2.UP)
	velocity.x = lerp(velocity.x, 0, Global.HORI_STOP)
	
	setAnimationFromState()
