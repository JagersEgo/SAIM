extends TuiNode
class_name TuiPicker

#signal pressed
signal changed(value: String)

enum styles {
	PICKER,
	ARRAY
}

@export var options : Array[String]
@export var default : int
@export var prefix : String = ""
@export var style : styles

var selected : int
var len_options : int

func _ready() -> void:
	len_options = len(options)
	assert(default >= 0)
	assert(len_options > default)
	selected = default
	
	interactable = true

func body(_selected: bool) -> Array[String]:
	if style == styles.PICKER:
		return ["%s \\l%s\\l < \\b%s\\b > \\l%s\\l" % \
			[prefix,
			options[(selected - 1) % len_options],
			options[selected],
			options[(selected + 1) % len_options]]
		] 
	elif style == styles.ARRAY:
		var output := ""
		for i in range(len_options):
			if i > 0:
				output += ", "
			
			if i == selected:
				output += "\\b<%s>\\b" % options[i]
			else:
				output += "\\l%s\\l" % options[i]
		
		return ["%s %s" % [prefix, output]]
	else:
		return ["ERROR"]

func interact() -> void:
	self.hscroll(false)

func hscroll(left: bool) -> bool:
	var delta := -1 if left else 1
	selected = (selected + delta) % len_options
	if selected == -1: selected = len_options - 1
	
	changed.emit(options[selected])
	
	return false

func get_value() -> String:
	return options[selected]
