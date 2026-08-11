extends Node

@onready var plugins_folder = ConfigManager.get_game_root().path_join("plugins")

func _ready() -> void:
	var files : Array[String] = get_gd_files(plugins_folder)
	
	for file in files:
		var plugin := load(file)
		var pname := file.get_file()
		print("[Plugin] Loaded ", pname)
		
		var plugin_instance = plugin.new()
		plugin_instance.name = file.get_file()
		self.add_child(plugin_instance)


func get_gd_files(path: String) -> Array[String]:
	var files: Array[String] = []
	_scan_directory(path, files)
	files.sort()
	return files


func _scan_directory(path: String, files: Array[String]) -> void:
	var dir := DirAccess.open(path)
	if dir == null:
		push_error("Couldn't open directory: " + path)
		return

	dir.list_dir_begin()

	while true:
		var name := dir.get_next()
		if name == "":
			break
		if name.begins_with(".") or name.begins_with("_"):
			continue
		if name.get_extension() == "gd":
			var full_path := path.path_join(name)
			files.append(full_path)
		
	dir.list_dir_end()
