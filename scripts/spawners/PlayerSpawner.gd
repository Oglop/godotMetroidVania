extends Node2D

var Player = preload("res://scenes/player/player.tscn")
var Tail = preload("res://scenes/player/Tail.tscn")

func _ready():
	
	
	
	var parent = self.get_parent()
	var player = Player.instance()
	player.get_node("PlayerBody").setPosition(100, 80)
	var tail1 = Tail.instance()
	var tail2 = Tail.instance()
	var tail3 = Tail.instance()
	tail1.setPositionInTail(6)
	tail2.setPositionInTail(12)
	tail3.setPositionInTail(18)
	
	self.add_child(tail3)
	self.add_child(tail2)
	self.add_child(tail1)
	self.add_child(player)
	
	


