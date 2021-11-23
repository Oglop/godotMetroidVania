extends Node2D

var life = 50
var up = -50
var down = 0



# Called when the node enters the scene tree for the first time.
func _ready():
	#setValues(50, 50, 47, true)
	pass

func _physics_process(delta):
	self.global_position.y += (up * delta) + (down * delta)
	down += 3
	life -= 1
	if life < 0:
		queue_free()

func setValues(x, y, value, isDamage):
	self.global_position.x = x
	self.global_position.y = y
	if isDamage:
		if life % 2 == 0:
			$lblDamage.add_color_override("font_color", Color.red)
		else:
			$lblDamage.add_color_override("font_color", Color.hotpink)
	else:
		if life % 2 == 0:
			$C.add_color_override("font_color", Color.green)
		else:
			$lblDamage.add_color_override("font_color", Color.darkgreen)
		
	if value <= 12:
		$lblDamage.get_font("font").size = 8
	elif value > 12 && value <= 49: 
		$lblDamage.get_font("font").size = 12
	else:
		$lblDamage.get_font("font").size = 16
	$lblDamage.text = str(value)
