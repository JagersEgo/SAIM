extends Node2D
class_name TUIContainer

func _ready() -> void:
	var screen_center = get_viewport_rect().size / 2
	position = screen_center

func _on_tui_scene_tree_exiting() -> void:
	#get_tree().quit()
	pass
