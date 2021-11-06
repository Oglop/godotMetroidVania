extends Node2D

onready var lblTitle = get_node("CanvasLayer/lblTitle")

func entersFrom(room, x, y):
	pass

# Called when the node enters the scene tree for the first time.
func _ready():
	if Global.CURRENT_ROOM == Global.ROOMS.TEST_ROOM_1:
		lblTitle.text = Data.rooms.testRoom1.title
	
func _physics_process(delta):
	if Input.action_press("ACTION_SUB"):
		emit_signal(Events.transitionToRoom)
	


