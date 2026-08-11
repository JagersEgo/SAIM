extends Node

func _input(event: InputEvent) -> void:
	if event.is_action_pressed("quick_close"):
		get_tree().quit()
