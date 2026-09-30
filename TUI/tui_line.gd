extends TuiCentreComment
class_name TuiLine

@export var _TEXT_IS_NOT_USED : bool

func _ready() -> void:
	interactable = false
	text.resize(1)
	text[0] = "─".repeat(width)
