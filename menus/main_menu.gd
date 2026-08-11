extends Node

const SCENARIO_SELECT := preload("uid://cjgcrnegf7gx4")

@export var tui_scene : Node

func _on_tui_button_pressed() -> void:
	tui_scene.replace(SCENARIO_SELECT)


func _on_tui_button_4_pressed() -> void:
	get_tree().quit()
