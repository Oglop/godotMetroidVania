extends Node2D

onready var Monster = preload("res://scenes/world/Monster.tscn")
onready var Damage = preload("res://scenes/effects/DamageText.tscn")
var rng = RandomNumberGenerator.new()
enum STATES {
	WAITING,
	SPAWNING,
	FULL,
}

var state = STATES.WAITING

func _ready():
	Events.connect("monsterWasKilled", self, "_on_MonsterWasKilled")
	Events.connect("damageAppliedAt", self, "_on_damageAppliedAt")
	$MonsterSpawnerSprite.hide()
	_resetTimer(0.1, 1.0)
	
func _resetTimer(minTime = 10.0, maxTime = 30.0):
	var randomTime = rng.randf_range(minTime, maxTime)
	$MonsterSpawnerTimer.wait_time = randomTime
	$MonsterSpawnerTimer.start()

func _canSpawnNewMonster() -> bool:
	var count = 0
	var children = self.get_children()
	for child in children:
		var groups = child.get_groups()
		for group in groups:
			if group == "monster":
				count += 1
				
	if count >= 3:
		state = STATES.FULL
		return false
	return true
	
func _physics_process(delta):
	if state != STATES.SPAWNING:
		$MonsterSpawnerSprite.hide()
	if state == STATES.SPAWNING:
		$MonsterSpawnerSprite.show()
		$MonsterSpawnerSprite.play("spawning")

func _on_MonsterWasKilled():
	if state == STATES.FULL:
		if _canSpawnNewMonster():
			state = STATES.WAITING
			_resetTimer()

func _on_MonsterSpawnerTimer_timeout():
	if state == STATES.WAITING:
		if _canSpawnNewMonster():
			state = STATES.SPAWNING
			_resetTimer(2.0, 6.0)
	elif state == STATES.SPAWNING:
		var newMonster = Monster.instance()
		self.add_child(newMonster)
		var type = RoomDataHandler.getMonsterSpawnType()
		newMonster.setMonsterType(type, self.global_position)
		
		state = STATES.WAITING
		_resetTimer()
		
func _on_damageAppliedAt(globalx: float, globaly :float, value: int, isDamage: bool) -> void:
	var dmg = Damage.instance()
	self.add_child(dmg)
	dmg.setValues(globalx, globaly, value, isDamage)
	
		
