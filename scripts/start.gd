extends Node2D


# Declare member variables here. Examples:
# var a = 2
# var b = "text"


# Called when the node enters the scene tree for the first time.
func _ready():
	randomize()
	IoHandler.loadGame()
	Global.saveGameData.currentHP = Global.saveGameData.maxHP
	#get_tree().change_scene("res://scenes/world/World.tscn")
	get_tree().change_scene("res://scenes/world/StartRoom.tscn")


# Called every frame. 'delta' is the elapsed time since the previous frame.
#func _process(delta):
#	pass
