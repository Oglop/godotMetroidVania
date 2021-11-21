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
	if Global.CURRENT_ROOM == Global.ROOMS.PLAINS_START && Global.PREVIOUS_ROOM == Global.ROOMS.PLAINS_VILLAGE_WEST:
		startX = 808
		startY = 192
	if Global.CURRENT_ROOM == Global.ROOMS.PLAINS_VILLAGE_WEST && Global.PREVIOUS_ROOM == Global.ROOMS.PLAINS_START:
		startX = 72
		startY = 224
	if Global.CURRENT_ROOM == Global.ROOMS.PLAINS_VILLAGE_WEST && Global.PREVIOUS_ROOM == Global.ROOMS.GUILD:
		startX = 328
		startY = 192

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
	
	Global.playerState = Global.PLAYER_STATE.IDLE
	
	


