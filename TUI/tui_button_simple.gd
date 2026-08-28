extends TuiNode
class_name TuiButtonSimple

signal pressed

@export var text : String

func _ready() -> void:
	interactable = true

func body(_selected: bool) -> Array[String]:
	return [text]

func interact() -> void:
	pressed.emit()
