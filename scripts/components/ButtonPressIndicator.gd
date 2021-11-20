extends AnimatedSprite

# Called when the node enters the scene tree for the first time.
func _ready():
	Events.connect("pressButtonIndicator", self, "_on_setVisible")

func _on_setVisible(visible: bool) -> void:
	if visible:
		self.show()
	else:
		self.hide()
