extends KinematicBody2D

var velocity = Vector2(0,0)
var flipped = false

func _ready():
	if Global.saveGameData.weapon.tier1.equiped == true:
		$Duration.wait_time = Data.tailData.weapons.swordAttackTier1.duration;
	elif Global.saveGameData.weapon.tier2.equiped == true:
		$Duration.wait_time = Data.tailData.weapons.swordAttackTier2.duration;
	else:
		$Duration.wait_time = Data.tailData.weapons.swordAttackTier3.duration;
	$Duration.start()

func _on_Duration_timeout():
	queue_free()

func _setAnimation() -> void:
	if Global.saveGameData.weapon.tier1.equiped == true:
		$SwordAttackSprite.play("tier1")
	elif Global.saveGameData.weapon.tier2.equiped == true:
		$SwordAttackSprite.play("tier2")
	else:
		$SwordAttackSprite.play("tier3")

func _physics_process(delta):
	$SwordAttackSprite.flip_h = flipped
	if Global.saveGameData.weapon.tier1.equiped == true:
		if !flipped:
			velocity.x = Data.tailData.weapons.swordAttackTier1.speed
		else:
			velocity.x = -Data.tailData.weapons.swordAttackTier1.speed
	elif Global.saveGameData.weapon.tier2.equiped == true:
		if !flipped:
			velocity.x = Data.tailData.weapons.swordAttackTier2.speed
		else:
			velocity.x = -Data.tailData.weapons.swordAttackTier2.speed
	else:
		if !flipped:
			velocity.x = Data.tailData.weapons.swordAttackTier3.speed
		else:
			velocity.x = -Data.tailData.weapons.swordAttackTier3.speed
	
	self.move_and_slide(velocity, Vector2.UP)

func setValues(_position: Vector2, _isFlipped: bool) -> void:
	self.global_position = _position
	self.flipped = _isFlipped
