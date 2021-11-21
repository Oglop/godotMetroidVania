extends Node2D




# Called when the node enters the scene tree for the first time.
func _ready():
	randomize()
	IoHandler.loadGame(1)
	Global.saveGameData.currentHP = Global.saveGameData.maxHP
	#get_tree().change_scene("res://scenes/world/World.tscn")
	get_tree().change_scene("res://scenes/world/StartRoom.tscn")


# Called every frame. 'delta' is the elapsed time since the previous frame.
#func _process(delta):
#	pass
