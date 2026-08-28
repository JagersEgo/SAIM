extends TuiNode
class_name TuiCentreButton

signal pressed

@export var text : String
@export var width : int = 52


func _ready() -> void:
	interactable = true
	text = center_string(text, width)

func body(_selected: bool) -> Array[String]:
	var t = "%s" %[text]
	return [t]

func interact() -> void:
	pressed.emit()

func center_string(s: String, w: int) -> String:
	var padding := w - s.length()
	var left := padding / 2
	var right := padding - left # Extra space goes on the right if padding is odd
	
	return " ".repeat(left) + s + " ".repeat(right)
