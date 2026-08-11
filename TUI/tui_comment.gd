extends TuiNode
class_name TuiComment

@export var text : Array[String]

func _ready() -> void:
	interactable = false

func body(_selected: bool) -> Array[String]:
	return text

func interact() -> void:
	print("Ouch")
	return
