extends Node

@onready var fullscreen_indicator: TuiComment = $"../FullscreenIndicator"

func _on_tui_button_simple_2_pressed() -> void:
	get_parent().queue_free()

func _ready() -> void:
	fullscreen_indicator.text[0] = "    | " + str(DisplayServer.window_get_mode())
	%MuteIndicator.text[0] =  "    | " + str(AudioServer.is_bus_mute(AudioServer.get_bus_index("Master")))

func _on_tui_button_simple_pressed() -> void:
	if DisplayServer.window_get_mode() == DisplayServer.WINDOW_MODE_WINDOWED:
		DisplayServer.window_set_mode(DisplayServer.WINDOW_MODE_EXCLUSIVE_FULLSCREEN)
	else:
		DisplayServer.window_set_mode(DisplayServer.WINDOW_MODE_WINDOWED)
	
	fullscreen_indicator.text[0] = "    | " + str(DisplayServer.window_get_mode())


func _on_tui_button_simple_3_pressed() -> void:
	var master_bus = AudioServer.get_bus_index("Master")

	AudioServer.set_bus_mute(
		master_bus,
		not AudioServer.is_bus_mute(master_bus)
	)
	
	%MuteIndicator.text[0] =  "    | " + str(AudioServer.is_bus_mute(AudioServer.get_bus_index("Master")))
