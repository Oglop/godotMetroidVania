extends Node

var path1 = "user://data/data1.json"
var path2 = "user://data/data2.json"
var path3 = "user://data/data3.json"

func saveFileExists(path: String) -> bool:
	var file = File.new()
	if file.file_exists(path):
		return true
	return false
	
func _getPathBySaveSlot(saveSlot: int) -> String:
	var path = ""
	if saveSlot == 1:
		path = path1
	elif saveSlot == 2:
		path = path2
	elif saveSlot == 3:
		path = path3
	return path
	
func getFormatedDateString() -> String:
	var time = OS.get_datetime()
	var dayofweek = time["weekday"]
	var day = time["day"]
	var month = time["month"]
	var year = time["year"]     
	var hour = time["hour"]
	var minute=  time["minute"]
	var second = time["second"]
	var nameweekday= ["Sun", "Mon", "Tue", "Wed", "Thu", "Fri", "Sat"]
	var date = "%s, %d%02d%02d %02d:%02d:%02d" % [nameweekday[dayofweek], year, month-1, day, hour, minute, second]
	return date
	
func getSaveSlotInfo(saveSlot: int) -> String:
	var slotInfo = LanguageHandler.getText("save_slot_empty")
	var path = _getPathBySaveSlot(saveSlot)
	if saveFileExists(path):
		var file = File.new()
		file.open(path, file.READ)
		var text = file.get_as_text()
		var json = parse_json(text)
		slotInfo = json.lastSave
	return slotInfo
	
func getSaveSlotEmpty(saveSlot: int) -> bool:
	var path = _getPathBySaveSlot(saveSlot)
	if saveFileExists(path):
		return true
	return false

func saveGame(saveSlot: int) -> void:
	Global.saveGameData.lastSave = getFormatedDateString()
	var path = _getPathBySaveSlot(saveSlot)
	var file = File.new()
	file.open(path, File.WRITE)
	file.store_line(to_json(Global.saveGameData))
	
func loadGame(saveSlot: int) -> void:
	var path = _getPathBySaveSlot(saveSlot)
	var file = File.new()
	if !saveFileExists(path):
		resetData()
		return
	file.open(path, file.READ)
	var text = file.get_as_text()
	Global.saveGameData = parse_json(text)
	file.close()

func resetData() -> void:
	Global.saveGameData = Data.data.duplicate(true)
	
