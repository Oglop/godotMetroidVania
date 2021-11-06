extends Node2D

var bomb = preload("res://scenes/effects/PlayerBomb.tscn")

func _ready():
	Events.connect("tailBombDrop", self, "_on_tailBombDrop")
	
	
func _on_tailBombDrop(_x, _y):
	var newBomb = bomb.instance()
	newBomb.position.x = _x
	newBomb.position.y = _y
	self.add_child(newBomb)
