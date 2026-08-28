extends Node

const HELP_CONFIG = preload("res://menus/help_config.tscn")

func _on_tui_button_2_pressed() -> void:
	get_parent().queue_free()

func _on_tui_button_3_pressed() -> void:
	get_parent().adopt(HELP_CONFIG.instantiate())
