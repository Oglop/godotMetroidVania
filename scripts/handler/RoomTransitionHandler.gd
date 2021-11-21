extends Node

func _ready():
	Events.connect("transitionToRoom", self, "_on_goToRoom")

func _on_goToRoom(goTo, x, y):
	print("GOTO: " + goTo + "X: " + str(x) + ",Y: " + str(y))
	print("Global.PREVIOUS_ROOM: " + str(Global.PREVIOUS_ROOM) + ", Global.CURRENT_ROOM: " + str(Global.CURRENT_ROOM))
	Global.PREVIOUS_ROOM = Global.CURRENT_ROOM
	#Global.CURRENT_ROOM = goTo
	if goTo == "PREVIOUS_ROOM":
		var room = Global.CURRENT_ROOM
		Global.CURRENT_ROOM = Global.PREVIOUS_ROOM
		Global.PREVIOUS_ROOM = room
		_setSceneToTree() 
	if Global.CURRENT_ROOM == Global.ROOMS.PLAINS_START:
		if x > 0 && x < 1000 && y > 0 && y < 1000:
			Global.CURRENT_ROOM = Global.ROOMS.TEST_ROOM_1
			_setSceneToTree()

func _setSceneToTree() -> void:
	if Global.CURRENT_ROOM == Global.ROOMS.TEST_ROOM_1:
		get_tree().change_scene("res://scenes/world/World.tscn")
	if Global.CURRENT_ROOM == Global.ROOMS.PLAINS_START:
		get_tree().change_scene("res://scenes/world/StartRoom.tscn")

func _on_goToWorld(goTo):
	Global.PREVIOUS_ROOM = Global.CURRENT_ROOM
	Global.CURRENT_ROOM = goTo
