extends TuiCentreComment
class_name TuiLine

@warning_ignore("unused_private_class_variable")
@export var _TEXT_IS_NOT_USED : bool

func _ready() -> void:
	interactable = false
	text.resize(1)
	text[0] = "─".repeat(width)
