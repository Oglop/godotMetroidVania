extends CPUParticles2D


func _ready():
	#self.emitting = false
	Events.connect("setParticleEffects", self, "_on_setParticleEffect")
	
func _on_setParticleEffect(type):
	if type == Global.ROOM_PARTICLE_EFFECTS.LEAVES:
		self.emitting = true
		pass
	else:
		self.emitting = true

