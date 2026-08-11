extends Node2D
class_name TuiNode

var interactable : bool = false

# Return how many lines consumed by render
func body(_selected: bool) -> Array[String]:
	return [""]

# True => exit node
# False => cursor inside node
func vscroll(_up: bool) -> bool:
	return true

# True => exit node
# False => cursor inside node
func hscroll(_left: bool) -> bool:
	return true

func interact() -> void:
	return
