extends Node2D

enum DOOR_STATE {
	OPEN, CLOSED, LOCKED, UNLOCKED
}

var state = DOOR_STATE.CLOSED

# Called when the node enters the scene tree for the first time.
func _ready():
	pass # Replace with function body.


func _process(delta):
	if state == DOOR_STATE.CLOSED:
		$DoorSprite.play("closed")
	if state == DOOR_STATE.OPEN:
		$DoorSprite.play("closed")

