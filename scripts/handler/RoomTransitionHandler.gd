extends Node



# Called when the node enters the scene tree for the first time.
func _ready():
	pass # Replace with function body.

func _on_goToRoom(goTo):
	Global.PREVIOUS_ROOM = Global.CURRENT_ROOM
	Global.CURRENT_ROOM = goTo
	if Global.CURRENT_ROOM == Global.ROOMS.PLAINS_START:
		get_tree().change_scene("res://scenes/world/World.tscn")

	
func _on_goToWorld(goTo):
	Global.PREVIOUS_ROOM = Global.CURRENT_ROOM
	Global.CURRENT_ROOM = goTo
