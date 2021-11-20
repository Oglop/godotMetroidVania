extends Node



# Called when the node enters the scene tree for the first time.
func _ready():
	Events.connect("transitionToRoom", self, "_on_goToRoom")

func _on_goToRoom(goTo, x, y):
	print("GOTO: " + goTo + "X: " + str(x) + ",Y: " + str(y))
	print("Global.PREVIOUS_ROOM: " + str(Global.PREVIOUS_ROOM) + ", Global.CURRENT_ROOM: " + str(Global.CURRENT_ROOM))
	Global.PREVIOUS_ROOM = Global.CURRENT_ROOM
	#Global.CURRENT_ROOM = goTo
	if Global.CURRENT_ROOM == Global.ROOMS.PLAINS_START:
		if x > 0 && x < 1000 && y > 0 && y < 1000:
			Global.CURRENT_ROOM = Global.ROOMS.TEST_ROOM_1
			Events.emit_signal("setParticleEffects", Global.ROOM_PARTICLE_EFFECTS.LEAVES)
			get_tree().change_scene("res://scenes/world/World.tscn")

func _on_goToWorld(goTo):
	Global.PREVIOUS_ROOM = Global.CURRENT_ROOM
	Global.CURRENT_ROOM = goTo
