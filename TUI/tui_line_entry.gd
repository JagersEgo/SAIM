extends TuiNode
class_name TuiLineEntry

signal text_changed

@onready var line_edit: LineEdit = $LineEdit

@export var prefix : String
#@export var max_width : int = 52

const selection_delimiter : String = "\\b"
const len_selection_delimiter := 1

const s_caret = "|"

func _ready() -> void:
	interactable = true

func body(_selected: bool) -> Array[String]:
	var text := line_edit.text
	if !line_edit.is_editing(): return [prefix + text]
	
	if line_edit.has_selection():
		var from := line_edit.get_selection_from_column()
		var to := line_edit.get_selection_to_column()

		if from != to:
			text = text.left(from) + \
			selection_delimiter + \
			text.substr(from, to - from) + \
			selection_delimiter + \
			text.substr(to)
			return [prefix + text]
		
	var caret := line_edit.get_caret_column()
	text = text.left(caret) + s_caret + text.substr(caret)
	return [prefix + text]


# True => exit node
# False => cursor inside node
func hscroll(left: bool) -> bool:
	if !left:
		line_edit.clear()
	
	return false

func interact() -> void:
	if !line_edit.is_editing():
		line_edit.edit.call_deferred()
	else:
		line_edit.unedit.call_deferred()

func _on_line_edit_text_changed(_new_text: String) -> void:
	if get_parent() is TuiScene:
		text_changed.emit()
		get_parent().queue_redraw()
		
func get_text():
	return line_edit.text
