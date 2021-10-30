extends Node2D

var positionInTail = 0

# Called when the node enters the scene tree for the first time.
func _ready():
	pass # Replace with function body.
	
func setPositionInTail(_position):
	positionInTail = _position
	
func _physics_process(delta):
	if Global.playerState != Global.PLAYER_STATE.IDLE:
		self.position = Vector2(Global.X_POSITIONS[positionInTail], Global.Y_POSITIONS[positionInTail])


