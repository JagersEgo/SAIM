extends TuiNode
class_name TuiConfigDisplay

var text : Array[String]

const TYPE_LEN := 5
const TOP_LINE := "\\i[CATEGORY] <TYPE> KEY = VALUE (DEFAULT)\\i"

func _ready() -> void:
	interactable = false

func parse(entries) -> void:
	var lines: Array[String] = [TOP_LINE]

	var max_key_len := 0
	for entry in entries:
		var l = len(entry.get("key", ""))
		if l > max_key_len:
			max_key_len = l

	for entry in entries:
		lines.append(
			"[%s] <%s> %s = %s (%s)" % [
				entry.get("section", ""),
				entry.get("type", "").rpad(TYPE_LEN),
				entry.get("key", "").rpad(max_key_len+1),
				str(entry.get("value", "")),
				str(entry.get("default", ""))
			]
		)

	text = lines

func body(_selected: bool) -> Array[String]:
	return text

func interact() -> void:
	print("Ouch")
	return
