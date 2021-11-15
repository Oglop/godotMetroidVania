extends KinematicBody2D


var flipped = false
var velocity = Vector2(0,0)

func _ready():
	$Duration.wait_time = Data.tailData.weapons.wizardFireball.duration;
	$Duration.start()

func _on_Duration_timeout():
	queue_free()

func _physics_process(delta):
	$WizardFireballSprite.flip_h = flipped
	if !flipped:
		velocity.x = Data.tailData.weapons.wizardFireball.speed
	else:
		velocity.x = -Data.tailData.weapons.wizardFireball.speed
	self.move_and_slide(velocity, Vector2.UP)

func setValues(_position: Vector2, _isFlipped: bool) -> void:
	self.global_position = _position
	self.flipped = _isFlipped
