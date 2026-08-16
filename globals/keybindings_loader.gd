extends Node

const CONFIG_FILE_NAME := "input_map.ini"

# Setting format
# section = INI section3
# key     = INI key
# prop    = member variable to read/write
# type    = serializer/deserializer
# default = fallback value
const SETTINGS := [
	{
		"section": "binds",
		"key": "ui_back",
		"prop": "ui_back",
		"type": "string",
		"default": "escape",
	},
	{
		"section": "binds",
		"key": "ui_select",
		"prop": "ui_select",
		"type": "string",
		"default": "space, enter",
	},
	{
		"section": "binds",
		"key": "ui_up",
		"prop": "ui_up",
		"type": "string",
		"default": "w",
	},
	{
		"section": "binds",
		"key": "ui_down",
		"prop": "ui_down",
		"type": "string",
		"default": "s",
	},
	{
		"section": "binds",
		"key": "ui_left",
		"prop": "ui_left",
		"type": "string",
		"default": "a",
	},
	{
		"section": "binds",
		"key": "ui_right",
		"prop": "ui_right",
		"type": "string",
		"default": "d",
	},
]

var ui_back : String
var ui_back_action = "ui_cancel"
var ui_select : String
var ui_select_action = "ui_accept"
var ui_up : String
var ui_up_action = "ui_up"
var ui_down : String
var ui_down_action = "ui_down"
var ui_left : String
var ui_left_action = "ui_left"
var ui_right : String
var ui_right_action = "ui_right"

#var inputs = [ui_back, ui_select, ui_up, ui_down, ui_left, ui_right]

func _ready() -> void:
	print("[Keybindings Loader] Start: ", Time.get_ticks_msec())
	
	ConfigManager.load_config(CONFIG_FILE_NAME, SETTINGS, self)
	
	var pairs = [
		[ui_back, ui_back_action],
		[ui_select, ui_select_action],
		[ui_up, ui_up_action],
		[ui_down, ui_down_action],
		[ui_left, ui_left_action],
		[ui_right, ui_right_action]
	]
	
	for i in pairs:
		var inputs : String = i[0]
		var action : String = i[1]
		
		InputMap.action_erase_events(action)
		
		var keys = inputs.split(",", false)
		
		for key in keys:
			key = key.strip_edges()
		
			var kc = OS.find_keycode_from_string(key)
			if kc == 0:
				ConfigManager.push_notification(
					ConfigManager.NotificationTypes.WARN,
					self.name,
					"Unknown key: \"" + key + "\" for " + action
				)
			
			var event := InputEventKey.new()
			event.physical_keycode = kc
			
			InputMap.action_add_event(action, event)
	
	print("[Keybindings Loader] End: ", Time.get_ticks_msec())
