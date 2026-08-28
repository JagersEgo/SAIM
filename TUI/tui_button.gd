extends TuiNode
class_name TuiButton

signal pressed

@export var text : String
@export var marker : String

func _ready() -> void:
	interactable = true

func body(selected: bool) -> Array[String]:
	var t = "[%c]%c| %s" %[marker, "▶" if selected else " ", text]
	return [t]

func interact() -> void:
	pressed.emit()
