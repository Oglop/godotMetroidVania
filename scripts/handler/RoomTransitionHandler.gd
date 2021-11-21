extends Node

func _ready():
	Events.connect("transitionToRoom", self, "_on_goToRoom")

func _on_goToRoom(goTo, x, y):
	print("GOTO: " + str(goTo) + "X: " + str(x) + ",Y: " + str(y))
	print("Global.PREVIOUS_ROOM: " + str(Global.PREVIOUS_ROOM) + ", Global.CURRENT_ROOM: " + str(Global.CURRENT_ROOM))
	Global.PREVIOUS_ROOM = Global.CURRENT_ROOM
	#Global.CURRENT_ROOM = goTo
	if Global.CURRENT_ROOM == Global.ROOMS.GUILD:
		Global.CURRENT_ROOM = goTo
		_setSceneToTree() 
	if Global.CURRENT_ROOM == Global.ROOMS.PLAINS_START:
		if x > 0 && x < 1000 && y > 0 && y < 1000:
			Global.CURRENT_ROOM = Global.ROOMS.PLAINS_VILLAGE_WEST
			_setSceneToTree()
	if Global.CURRENT_ROOM == Global.ROOMS.PLAINS_VILLAGE_WEST: 
		# GUILD
		if x > 312 && x < 344 && y > 184 && y < 216:
			Global.CURRENT_ROOM = Global.ROOMS.GUILD
			_setSceneToTree()
		# PLAINS_START
		if x > 56 && x < 88 && y > 216 && y < 248:
			Global.CURRENT_ROOM = Global.ROOMS.PLAINS_START
			_setSceneToTree()

func _setSceneToTree() -> void:
	if Global.CURRENT_ROOM == Global.ROOMS.TEST_ROOM_1:
		get_tree().change_scene("res://scenes/world/World.tscn")
	if Global.CURRENT_ROOM == Global.ROOMS.PLAINS_START:
		get_tree().change_scene("res://scenes/world/StartRoom.tscn")
	if Global.CURRENT_ROOM == Global.ROOMS.PLAINS_VILLAGE_WEST:
		get_tree().change_scene("res://scenes/world/PlainsVillageWestRoom.tscn")
	if Global.CURRENT_ROOM == Global.ROOMS.GUILD:
		get_tree().change_scene("res://scenes/world/ChosePartyRoom.tscn")
