extends Node

enum NotificationTypes {
	NOTICE,
	WARN,
	ERROR,
	FATAL
}

const VERSION_SECTION := "meta"
const VERSION_KEY := "game_version"

# Format: [[NotificationTypes, String]...]
var notifications : Array = []

func get_game_version() -> String:
	return ProjectSettings.get_setting("application/config/version", "0.0.0")

func get_config_path(file: String) -> String:
	return get_game_root().path_join(file)

func get_game_root() -> String:
	if OS.has_feature("editor"):
		return ProjectSettings.globalize_path("res://")
	else:
		return OS.get_executable_path().get_base_dir()

func apply_defaults(settings, holder) -> void:
	for setting in settings:
		holder.set(setting.prop, setting.default)

func load_config(config_path: String, settings, holder) -> void:
	print("[Config] Loading config from: %s" % config_path)
	apply_defaults(settings, holder)

	var config := ConfigFile.new()
	var err := config.load(config_path)

	if err != OK:
		print("[Config] Config file not found, writing defaults.")
		save_config(config_path, settings, holder)
		return

	var current_version := get_game_version()
	var saved_version : String = config.get_value(
		VERSION_SECTION,
		VERSION_KEY,
		""
	)

	if saved_version != current_version:
		print("[Config] Version changed: %s -> %s" % [saved_version, current_version])

		# TODO:
		# Perform migrations here.

		# Update the stored version so we don't detect it again next launch.
		config.set_value(
			VERSION_SECTION,
			VERSION_KEY,
			current_version
		)
		config.save(config_path)

	var missing_value := false

	for setting in settings:
		var fallback = setting.default
		
		if not config.has_section_key(setting.section, setting.key):
			missing_value = true

		var raw = config.get_value(setting.section, setting.key, _encode(setting.type, fallback))
		holder.set(setting.prop, _decode(setting.type, raw, fallback))

	if missing_value:
		print("[Config] Inserting missing values")
		save_config(config_path, settings, holder)

	print("[Config] Configuration loaded.")


func save_config(config_path: String, settings, holder) -> void:
	print("[Config] Saving config...")

	var config := ConfigFile.new()

	for setting in settings:
		config.set_value(
			setting.section,
			setting.key,
			_encode(setting.type, holder.get(setting.prop))
		)

	config.set_value(
		VERSION_SECTION,
		VERSION_KEY,
		get_game_version()
	)

	var dir_path := config_path.get_base_dir()

	if not DirAccess.dir_exists_absolute(dir_path):
		DirAccess.make_dir_recursive_absolute(dir_path)

	var err := config.save(config_path)

	if err == OK:
		print("[Config] Config saved successfully.")
	else:
		push_error("[Config] Failed to save config! Error: %d, %d" % err, config_path)


func _encode(type: String, value: Variant) -> Variant:
	match type:
		"color":
			return (value as Color).to_html()
		_:
			return value


func _decode(type: String, value: Variant, fallback: Variant) -> Variant:
	match type:
		"color":
			if value is String and Color.html_is_valid(value):
				return Color(value)

			push_warning("Invalid color, using default.", value)
			return fallback

		"int":
			if value is int:
				return value

			push_warning("Invalid integer, using default.", value)
			return fallback
		
		"float":
			if value is float:
				return value

			push_warning("Invalid float, using default.", value)
			return fallback

		_:
			return value

func push_notification(type: NotificationTypes, source: String, message: String):
	var line := "[%s]: %s" %[source, message]
	
	notifications.push_back([type, line])

func get_notifications():
	return notifications

## @deprecated: Should not be in this global
func load_png(path: String) -> Image:
	# File exists?
	if not FileAccess.file_exists(path):
		push_error("File does not exist: %s" % path)
		return null

	# Open file
	var file := FileAccess.open(path, FileAccess.READ)
	if file == null:
		push_error("Failed to open file: %s" % path)
		return null

	# Load the image
	var image := Image.new()
	var err := image.load(path)

	if err != OK:
		push_error("Failed to load PNG. Error code: %d" % err)
		return null

	# Sanity check
	if image.get_width() <= 0 or image.get_height() <= 0:
		push_error("Loaded image has invalid dimensions.")
		return null

	return image
