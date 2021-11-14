extends Node2D

var Player = preload("res://scenes/player/player.tscn")
var Tail = preload("res://scenes/player/Tail.tscn")

var startX = 0
var startY = 0



func setStartPosition():
	print("Global.PREVIOUS_ROOM: " + str(Global.PREVIOUS_ROOM) + ", Global.CURRENT_ROOM: " + str(Global.CURRENT_ROOM))
	if Global.CURRENT_ROOM == Global.ROOMS.PLAINS_START && Global.PREVIOUS_ROOM == Global.ROOMS.NONE:
		startX = -48
		startY = 272
	if Global.CURRENT_ROOM == Global.ROOMS.TEST_ROOM_1 && Global.PREVIOUS_ROOM == Global.ROOMS.PLAINS_START:
		startX = 500
		startY = 0

func _ready():
	
	setStartPosition()
	var player = Player.instance()
	player.get_node("PlayerBody").setPosition(startX, startY)
	var tail1 = Tail.instance()
	var tail2 = Tail.instance()
	var tail3 = Tail.instance()
	tail1.setPositionInTail(6, 1)
	tail2.setPositionInTail(12, 2)
	tail3.setPositionInTail(18, 3)
	
	self.add_child(tail3)
	self.add_child(tail2)
	self.add_child(tail1)
	self.add_child(player)
	
	


