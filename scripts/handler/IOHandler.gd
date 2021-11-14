extends Node

var path = "user://data/data.json"

func saveFileExists() -> bool:
	var file = File.new()
	if file.file_exists(Global.STORAGE_PATH):
		return true
	return false

func saveGame():
	var file = File.new()
	file.open(path, File.WRITE)
	file.store_line(to_json(Global.saveGameData))
	
func loadGame():
	var file = File.new()
	if !saveFileExists():
		resetData()
		return
	file.open(Global.STORAGE_PATH, file.READ)
	var text = file.get_as_text()
	Global.saveGameData = parse_json(text)
	file.close()

func resetData():
	Global.saveGameData = Data.data.duplicate(true)

