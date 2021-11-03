extends Node2D

signal goToWorld(room)

func entersFrom(room, x, y):
	pass

# Called when the node enters the scene tree for the first time.
func _ready():
	get_tree().get_node("RoomTransitionHandler").connect("goToWorld", self, "_on_goToWorld")
	
	emit_signal("goToWorld", Global.ROOMS.PLAINS_START)
	
	pass # Replace with function body.


