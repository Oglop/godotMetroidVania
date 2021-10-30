extends Node2D

var life = 50
var up = -50
var down = 0
onready var lbl = get_node("lblDamage")


# Called when the node enters the scene tree for the first time.
func _ready():
	setValues(50, 50, 47, true)
	pass

func _physics_process(delta):
	self.position.y += (up * delta) + (down * delta)
	down += 3
	life -= 1
	if life < 0:
		queue_free()

func setValues(x, y, value, isDamage):
	self.position.x = x
	self.position.y = y
	if isDamage:
		if life % 2 == 0:
			lbl.add_color_override("font_color", Color.red)
		else:
			lbl.add_color_override("font_color", Color.hotpink)
	else:
		if life % 2 == 0:
			lbl.add_color_override("font_color", Color.green)
		else:
			lbl.add_color_override("font_color", Color.darkgreen)
		
	if value <= 12:
		lbl.get_font("font").size = 8
	elif value > 12 && value <= 49: 
		lbl.get_font("font").size = 12
	else:
		lbl.get_font("font").size = 16
	lbl.text = str(value)
