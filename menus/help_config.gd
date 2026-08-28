extends Node

func _on_tui_button_simple_pressed() -> void:
	get_parent().queue_free()
