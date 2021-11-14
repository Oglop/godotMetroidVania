extends Node2D

enum DOOR_STATE {
	OPEN, CLOSED, LOCKED, UNLOCKED
}
var doorTimerDuration = 1.0

var state = DOOR_STATE.CLOSED

# Called when the node enters the scene tree for the first time.
func _ready():
	pass # Replace with function body.


func _process(delta):
	if state == DOOR_STATE.CLOSED:
		$DoorSprite.play("closed")
	if state == DOOR_STATE.OPEN:
		$DoorSprite.play("closed")
	if Input.is_action_just_pressed("UP"):
		if $Area2D.get_overlapping_bodies().size() > 0:
			var playerGroup = get_tree().get_nodes_in_group("player")
			var bodies = $Area2D.get_overlapping_bodies()
			for body in bodies:
				if body.is_in_group("player"):
					state = DOOR_STATE.OPEN
					$DoorTimer.start(doorTimerDuration)

func _on_DoorTimer_timeout():
	Events.emit_signal("transitionToRoom", "", self.global_position.x, self.global_position.y)
