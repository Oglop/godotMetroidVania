extends Node2D

enum STATE {
	IDLE, HIT, WALKING, FALLING
}

var velocity: Vector2 = Vector2(0,0)
var state = STATE.IDLE
var type = Global.MONSTERS.NONE
var title: String = ""
var HP: int = 0
var speed: int = 0
var defence: int = 0
var xp: int = 0
var flipped: bool = false


func _applyDamage(damage):
	var calculatedDamage = damage - defence
	if calculatedDamage < 0:
		calculatedDamage = 0
	HP -= calculatedDamage
	if calculatedDamage >= 0:
		Events.emit_signal("damageAppliedAt", calculatedDamage, self.global_position.x, self.global_position.y)

func _setAnimationByTypeAndState() -> void:
	$MonsterBody/MonsterSprite.flip_h = flipped
	if state == STATE.IDLE:
		if type == Global.MONSTERS.BUG:
			$MonsterBody/MonsterSprite.play("bug")
		if type == Global.MONSTERS.SCORPION:
			$MonsterBody/MonsterSprite.play("scorpion")
		if type == Global.MONSTERS.SQUID:
			$MonsterBody/MonsterSprite.play("squid")
	if state == STATE.HIT:
		if type == Global.MONSTERS.BUG:
			$MonsterBody/MonsterSprite.play("bugHit")
		if type == Global.MONSTERS.SCORPION:
			$MonsterBody/MonsterSprite.play("scorpionHit")
		if type == Global.MONSTERS.SQUID:
			$MonsterBody/MonsterSprite.play("squidHit")

func _setMonsterStats() -> void:
	if type == Global.MONSTERS.BUG:
		title = Data.monsters.bug.title
		HP = Data.monsters.bug.hp
		speed = Data.monsters.bug.speed
		defence = Data.monsters.bug.defence
		xp = Data.monsters.bug.xp
	if type == Global.MONSTERS.SCORPION:
		title = Data.monsters.scorpion.title
		HP = Data.monsters.scorpion.hp
		speed = Data.monsters.scorpion.speed
		defence = Data.monsters.scorpion.defence
		xp = Data.monsters.scorpion.xp

func _ready():
	var rng = RandomNumberGenerator.new()
	var i = rng.randi_range(0,1)
	if i == 0:
		flipped = false
	else:
		flipped = true

func _checkHP() -> void:
	if HP <= 0:
		#spawn effect
		Events.emit_signal("addXP", xp)
		self.queue_free()

func _physics_process(delta):
	velocity.y += Global.GRAVITY
	velocity = $MonsterBody.move_and_slide(velocity, Vector2.UP)
	_setAnimationByTypeAndState()

func setMonsterType(_type, position):
	self.global_position = position
	self.type = _type
	_setMonsterStats()

func _on_Area2D_body_entered(body):
	if "" in body.name:
		pass
	elif "" in body.name:
		pass
	
	
	
