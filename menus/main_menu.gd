extends Node

const SCENARIO_SELECT := preload("uid://cjgcrnegf7gx4")
const HELP = preload("res://menus/help.tscn")
const ACTIONS = preload("res://menus/actions.tscn")

@export var tui_scene : Node

func _on_tui_button_pressed() -> void:
	tui_scene.replace(SCENARIO_SELECT)


func _on_tui_button_4_pressed() -> void:
	get_tree().quit()


func _on_tui_button_2_pressed() -> void:
	tui_scene.adopt(HELP.instantiate())


func _on_tui_button_3_pressed() -> void:
	tui_scene.adopt(ACTIONS.instantiate())
