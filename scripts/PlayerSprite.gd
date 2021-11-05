extends AnimatedSprite


func _ready():
	#self.connect("animation_finished", self, "_on_PlayerSprite_animation_finished")
	pass

func _on_PlayerSprite_animation_finished():
	if self.animation == "lv1Attack" || self.animation == "lv2Attack" || self.animation == "lv3Attack":
		Global.playerState = Global.PLAYER_STATE.IDLE
	# Events.emit_signal("playerAnimationFinished", animation)
