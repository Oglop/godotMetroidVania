extends Node2D

var bomb = preload("res://scenes/effects/PlayerBomb.tscn")
var dwarfAxe = preload("res://scenes/interactives/DwarfAxe.tscn")
var thiefKnife = preload("res://scenes/interactives/ThiefKnife.tscn")
var wizardFireball = preload("res://scenes/interactives/WizardFireball.tscn")

func _ready():
	Events.connect("tailBombDrop", self, "_on_tailBombDrop")
	Events.connect("fireDwarfAxeProjectile", self, "_on_fireDwarfAxeProjectile")
	Events.connect("fireThiefKnifeProjectile", self, "_on_thiefKnifeProjectile")
	Events.connect("fireWizardSpellProjectile", self, "_on_wizardFireballProjectile")
	
func _on_fireDwarfAxeProjectile(fromPosition: Vector2, isFlipped: bool) -> void:
	var axe = dwarfAxe.instance()
	axe.setValues(fromPosition, isFlipped)
	self.add_child(axe)
	
func _on_thiefKnifeProjectile(fromPosition: Vector2, isFlipped: bool) -> void:
	var knife = thiefKnife.instance()
	knife.setValues(fromPosition, isFlipped)
	self.add_child(knife)

func _on_wizardFireballProjectile(fromPosition: Vector2, isFlipped: bool) -> void:
	var projectile = wizardFireball.instance()
	projectile.setValues(fromPosition, isFlipped)
	self.add_child(projectile)

func _on_tailBombDrop(_x, _y):
	var newBomb = bomb.instance()
	newBomb.position.x = _x
	newBomb.position.y = _y
	self.add_child(newBomb)
