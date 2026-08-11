extends Node

func _ready() -> void:
	var files := get_name_ini_files(ConfigManager.get_game_root().path_join("test").path_join("alpha"))
	print(files)

static func get_name_ini_files(directory: String) -> Array[String]:
	if not DirAccess.dir_exists_absolute(directory):
		push_warning("Failed to open directory: `%s`" % directory)
		return []

	return _scan_ini_files(directory)

static func _scan_ini_files(directory: String) -> Array[String]:
	var results: Array[String] = []

	var dir := DirAccess.open(directory)
	if dir == null:
		push_warning("Failed to open directory: %s" % directory)
		return results

	dir.list_dir_begin()

	while true:
		var file_name := dir.get_next()
		if file_name.is_empty():
			break

		if dir.current_is_dir():
			continue

		if file_name.get_extension().to_lower() == "ini":
			results.append((file_name))

	dir.list_dir_end()

	results.sort()

	return results
