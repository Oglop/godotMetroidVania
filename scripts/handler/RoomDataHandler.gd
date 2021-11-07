extends Node

var rng = RandomNumberGenerator.new()
# Called when the node enters the scene tree for the first time.
func _ready():
	pass # Replace with function body.

func getMonsterSpawnType(getBig: bool = false):
	var i = 0
	if getBig:
		i = 9
	else:
		i = rng.randi_range(0,7)
	if Global.CURRENT_ROOM == Global.ROOMS.TEST_ROOM_1:
		match i:
			0,1,2,3,4, 5: return Data.rooms.testRoom1.monsters.normal
			6,7: return Data.rooms.testRoom1.monsters.rare
			8: return Data.rooms.testRoom1.monsters.big
	else:
		return Data.rooms.testRoom1.monsters.normal
	
