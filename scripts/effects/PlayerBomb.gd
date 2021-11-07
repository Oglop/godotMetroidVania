extends Node2D

var STATE = "INIT"
var waitToCritical = 2.0
var waitToExplosion = 0.5
var velocity = Vector2(0,0)

func _process(delta):
	velocity.y += Global.GRAVITY
	velocity = $PlayerBombBody2D.move_and_slide(velocity, Vector2.UP)

func _ready():
	STATE = "COUNTDOWN"
	$PlayerBombBody2D/PlayerBombSprite.play("countdown")
	$PlayerBombBody2D/TimerToCritical.wait_time = waitToCritical
	$PlayerBombBody2D/TimerToCritical.start()
	
func _on_TimerToCritical_timeout():
	STATE = "CRITICAL"
	$PlayerBombBody2D/PlayerBombSprite.play("critical")
	$PlayerBombBody2D/TimerToExplosion.wait_time = waitToExplosion
	$PlayerBombBody2D/TimerToExplosion.start()

func _on_TimerToExplosion_timeout():#duration = 0.2, frequency = 15, amplitude = 5, priority = 0
	Events.emit_signal("shakeScreen", 0.1, 20, 8, 0)
	$PlayerBombBody2D/PlayerBombSprite.play("explode")
	$PlayerBombBody2D/ExplosionArea/ExplosionHitBox.disabled = false
	
func _on_PlayerBombSprite_animation_finished():
	if $PlayerBombBody2D/PlayerBombSprite.animation == "explode":
		self.queue_free()
