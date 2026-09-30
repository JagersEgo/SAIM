extends TuiNode
class_name TuiCentreComment

@export var text : Array[String]
@export var width : int = 52

func _ready() -> void:
	interactable = false
	
	for i in range(len(text)):
		text[i] = center_string(text[i], width)

func body(_selected: bool) -> Array[String]:
	return text

func center_string(s: String, w: int) -> String:
	var padding := w - s.length()
	var left := padding / 2
	var right := padding - left # Extra space goes on the right if padding is odd
	
	return " ".repeat(left) + s + " ".repeat(right)
