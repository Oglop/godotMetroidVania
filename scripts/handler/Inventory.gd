extends Node2D
# SWORD
onready var sword1EQ = get_node("MarginContainer/VBItems/GridContainer/CCSW1/swordTeir1Equiped")
onready var sword1AN = get_node("MarginContainer/VBItems/GridContainer/CCSW1/swordTeir1Sprite")
onready var sword2EQ = get_node("MarginContainer/VBItems/GridContainer/CCSW2/swordTeir2Equiped")
onready var sword2AN = get_node("MarginContainer/VBItems/GridContainer/CCSW2/swordTier2Sprite")
onready var sword3EQ = get_node("MarginContainer/VBItems/GridContainer/CCSW3/swordTeir3Equiped")
onready var sword3AN = get_node("MarginContainer/VBItems/GridContainer/CCSW3/swordTier3Sprite")

onready var armor1AN = get_node("MarginContainer/VBItems/GridContainer/CCARM1/armorTier1Sprite")
onready var armor1EQ = get_node("MarginContainer/VBItems/GridContainer/CCARM1/armorTeir1Equiped")
onready var armor2AN = get_node("MarginContainer/VBItems/GridContainer/CCARM2/armorTier2Sprite")
onready var armor2EQ = get_node("MarginContainer/VBItems/GridContainer/CCARM2/armorTeir2Equiped")
onready var armor3AN = get_node("MarginContainer/VBItems/GridContainer/CCARM3/armorTier3Sprite")
onready var armor3EQ = get_node("MarginContainer/VBItems/GridContainer/CCARM3/armorTeir3Equiped")

onready var shield1EQ = get_node("MarginContainer/VBItems/GridContainer/CCSHI1/shieldTeir1Equiped")
onready var shield1AN = get_node("MarginContainer/VBItems/GridContainer/CCSHI1/shieldTier1Sprite")
onready var shield2EQ = get_node("MarginContainer/VBItems/GridContainer/CCSHI2/shieldTeir2Equiped")
onready var shield2AN = get_node("MarginContainer/VBItems/GridContainer/CCSHI2/shieldTier2Sprite")
onready var shield3EQ = get_node("MarginContainer/VBItems/GridContainer/CCSHI3/shieldTeir3Equiped")
onready var shield3AN = get_node("MarginContainer/VBItems/GridContainer/CCSHI3/shieldTier3Sprite")

var rowIndex = 0
var colIndex = 0

var grid = [
	[0,0,0],
	[0,0,0],
	[0,0,0],
]
var gridSizeX = 2
var gridSizeY = 2


# Called when the node enters the scene tree for the first time.
func _ready():
	initializeUIGrid()
	
	
func isSelected(x,y):
	if rowIndex == y && colIndex == x:
		return true
	return false
	
	
func initializeUIGrid():
	# SWORD
	if Data.data.weapon.tier1.found == false:
		grid[0][0] = 1
	elif Data.data.weapon.tier1.found == true:
		grid[0][0] = 1
	if Data.data.weapon.tier1.equiped == true:
		grid[0][0] = 2
		
	if Data.data.weapon.tier2.found == false:
		grid[1][0] = 0
	elif Data.data.weapon.tier2.found == true:
		grid[1][0] = 1
	if Data.data.weapon.tier2.equiped == true:
		grid[1][0] = 2
		
	if Data.data.weapon.tier3.found == false:
		grid[2][0] = 0
	elif Data.data.weapon.tier3.found == true:
		grid[2][0] = 1
	if Data.data.weapon.tier3.equiped == true:
		grid[2][0] = 2
		
	# ARMOR
	if Data.data.armor.tier1.found == false:
		grid[0][1] = 1
	elif Data.data.armor.tier1.found == true:
		grid[0][1] = 1
	if Data.data.armor.tier1.equiped == true:
		grid[0][1] = 2
		
	if Data.data.armor.tier2.found == false:
		grid[1][1] = 0
	elif Data.data.armor.tier2.found == true:
		grid[1][1] = 1
	if Data.data.armor.tier2.equiped == true:
		grid[1][1] = 2
		
	if Data.data.armor.tier3.found == false:
		grid[2][1] = 0
	elif Data.data.armor.tier3.found == true:
		grid[2][1] = 1
	if Data.data.armor.tier3.equiped == true:
		grid[2][1] = 2
				
	# SHEILD
	if Data.data.shield.tier1.found == false:
		grid[0][2] = 1
	elif Data.data.shield.tier1.found == true:
		grid[0][2] = 1
	if Data.data.shield.tier1.equiped == true:
		grid[0][2] = 2
		
	if Data.data.shield.tier2.found == false:
		grid[1][2] = 0
	elif Data.data.shield.tier2.found == true:
		grid[1][2] = 1
	if Data.data.shield.tier2.equiped == true:
		grid[1][2] = 2
		
	if Data.data.shield.tier3.found == false:
		grid[2][2] = 0
	elif Data.data.shield.tier3.found == true:
		grid[2][2] = 1
	if Data.data.shield.tier3.equiped == true:
		grid[2][2] = 2
				
#
# Travers grid in direction
#
func traverseGrid(direction):
	if direction == Global.DIRECTIONS.RIGHT:
		for i in range(colIndex + 1, gridSizeX + 1):
			if (grid[i][rowIndex] != 0):
				print("X: " + str(i) + ", Y: " + str(rowIndex) + " = " + str(grid[i][rowIndex]))
				colIndex = i
				break
	if direction == Global.DIRECTIONS.UP:
		for i in range(rowIndex -1, -1, -1):
			if (grid[colIndex][i] != 0):
				rowIndex = i
				break
	if direction == Global.DIRECTIONS.LEFT:
		for i in range(colIndex -1, -1, -1):
			if (grid[i][rowIndex] != 0):
				colIndex = i
				break
	if direction == Global.DIRECTIONS.DOWN:
		for i in range(rowIndex + 1, gridSizeY + 1, 1):
			if (grid[colIndex][i] != 0):
				rowIndex = i
				break

#
#
#
func drawInventoryGrid():
	# SWORD 1
	if isSelected(0, 0):
		sword1AN.play("selected")
	elif Data.data.weapon.tier1.found == true:
		sword1AN.play("found")
	else:
		sword1AN.play("notFound")
	if Data.data.weapon.tier1.equiped == true:
		sword1EQ.show()
	else:
		sword1EQ.hide()
		
	#SWORD 2
	if isSelected(1, 0):
		sword2AN.play("selected")
	elif Data.data.weapon.tier2.found == true:
		sword2AN.play("found")
	else:
		sword2AN.play("notFound")
	if Data.data.weapon.tier2.equiped == true:
		sword2EQ.show()
	else:
		sword2EQ.hide()
		
	#SWORD 3
	if isSelected(2, 0):
		sword3AN.play("selected")
	elif Data.data.weapon.tier3.found == true:
		sword3AN.play("found")
	else:
		sword3AN.play("notFound")
	if Data.data.weapon.tier3.equiped == true:
		sword3EQ.show()
	else:
		sword3EQ.hide()
		
		
	# ARMOR 1
	if isSelected(0, 1):
		armor1AN.play("selected")
	elif Data.data.armor.tier1.found == true:
		armor1AN.play("found")
	else:
		armor1AN.play("notFound")
	if Data.data.armor.tier1.equiped == true:
		armor1EQ.show()
	else:
		armor1EQ.hide()
		
	#ARMOR 2
	if isSelected(1, 1):
		armor2AN.play("selected")
	elif Data.data.armor.tier2.found == true:
		armor2AN.play("found")
	else:
		armor2AN.play("notFound")
	if Data.data.armor.tier2.equiped == true:
		armor2EQ.show()
	else:
		armor2EQ.hide()
		
	#ARMOR 3
	if isSelected(2, 1):
		armor3AN.play("selected")
	elif Data.data.armor.tier3.found == true:
		armor3AN.play("found")
	else:
		armor3AN.play("notFound")
	if Data.data.armor.tier3.equiped == true:
		armor3EQ.show()
	else:
		armor3EQ.hide()
		
		
		# SHIELD 1
	if isSelected(0, 2):
		shield1AN.play("selected")
	elif Data.data.shield.tier1.found == true:
		shield1AN.play("found")
	else:
		shield1AN.play("notFound")
	if Data.data.shield.tier1.equiped == true:
		shield1EQ.show()
	else:
		shield1EQ.hide()
		
	# SHIELD 2
	if isSelected(1, 2):
		shield2AN.play("selected")
	elif Data.data.shield.tier2.found == true:
		shield2AN.play("found")
	else:
		shield2AN.play("notFound")
	if Data.data.shield.tier2.equiped == true:
		shield2EQ.show()
	else:
		shield2EQ.hide()
		
	# SHIELD 3
	if isSelected(2, 2):
		shield3AN.play("selected")
	elif Data.data.shield.tier3.found == true:
		shield3AN.play("found")
	else:
		shield3AN.play("notFound")
	if Data.data.shield.tier3.equiped == true:
		shield3EQ.show()
	else:
		shield3EQ.hide()
		

func setEquipedItem():
	if colIndex == 0 && rowIndex == 0:
		Data.data.weapon.tier1.equiped = true
		Data.data.weapon.tier2.equiped = false
		Data.data.weapon.tier3.equiped = false
	if colIndex == 1 && rowIndex == 0:
		Data.data.weapon.tier1.equiped = false
		Data.data.weapon.tier2.equiped = true
		Data.data.weapon.tier3.equiped = false
	if colIndex == 2 && rowIndex == 0:
		Data.data.weapon.tier1.equiped = false
		Data.data.weapon.tier2.equiped = false
		Data.data.weapon.tier3.equiped = true
		
	if colIndex == 0 && rowIndex == 1:
		Data.data.armor.tier1.equiped = true
		Data.data.armor.tier2.equiped = false
		Data.data.armor.tier3.equiped = false
	if colIndex == 1 && rowIndex == 1:
		Data.data.armor.tier1.equiped = false
		Data.data.armor.tier2.equiped = true
		Data.data.armor.tier3.equiped = false
	if colIndex == 2 && rowIndex == 1:
		Data.data.armor.tier1.equiped = false
		Data.data.armor.tier2.equiped = false
		Data.data.armor.tier3.equiped = true
		
	if colIndex == 0 && rowIndex == 2:
		Data.data.shield.tier1.equiped = true
		Data.data.shield.tier2.equiped = false
		Data.data.shield.tier3.equiped = false
	if colIndex == 1 && rowIndex == 2:
		Data.data.shield.tier1.equiped = false
		Data.data.shield.tier2.equiped = true
		Data.data.shield.tier3.equiped = false
	if colIndex == 2 && rowIndex == 2:
		Data.data.shield.tier1.equiped = false
		Data.data.shield.tier2.equiped = false
		Data.data.shield.tier3.equiped = true
		
		
func togglePause():
	var pauseState = not get_tree().paused
	get_tree().paused = pauseState
	self.visible = pauseState

func checkForInput():
	if Input.is_action_just_pressed("UP"):
		traverseGrid(Global.DIRECTIONS.UP)
	if Input.is_action_just_pressed("DOWN"):
		traverseGrid(Global.DIRECTIONS.DOWN)
	if Input.is_action_just_pressed("RIGHT"):
		traverseGrid(Global.DIRECTIONS.RIGHT)
	if Input.is_action_just_pressed("LEFT"):
		traverseGrid(Global.DIRECTIONS.LEFT)
	if Input.is_action_just_pressed("ACTION_MAIN"):
		setEquipedItem()
	if Input.is_action_just_pressed("PAUSE"):
		togglePause()
				
func _physics_process(delta):
	checkForInput()
	drawInventoryGrid()
