extends Node

var path = "user://data/data.json"


var data = {}

func saveGame():
	var file = File.new()
	file.open(path, File.WRITE)
	file.store_line(to_json(data))
	
func loadGame():
	var file = File.new()
	if not file.file_exists(Global.STORAGE_PATH):
		resetData()
		return
	file.open(Global.STORAGE_PATH, file.READ)
	var text = file.get_as_text()
	data = parse_json(text)
	file.close()

func resetData():
	data = Data.data.duplicate(true)

