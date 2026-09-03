extends Node

const CONFIG_FILE_NAME := "config.ini"

# Setting format
# section = INI section3
# key     = INI key
# prop    = member variable to read/write
# type    = serializer/deserializer
# default = fallback value
const SETTINGS := [
	{
		"section": "theme",
		"key": "bg_c",
		"prop": "bg_c",
		"type": "color",
		"default": Color("#1e1e2e"),
	},
	{
		"section": "theme",
		"key": "bg2_c",
		"prop": "bg2_c",
		"type": "color",
		"default": Color("#181825"),
	},
	{
		"section": "theme",
		"key": "bg3_c",
		"prop": "bg3_c",
		"type": "color",
		"default": Color("#1e1e2e"),
	},
	{
		"section": "theme",
		"key": "bg4_c",
		"prop": "bg4_c",
		"type": "color",
		"default": Color("#313244"),
	},
	{
		"section": "theme",
		"key": "fg_c",
		"prop": "fg_c",
		"type": "color",
		"default": Color("#cdd6f4"),
	},
	{
		"section": "theme",
		"key": "fg2_c",
		"prop": "fg2_c",
		"type": "color",
		"default": Color("#bac2de"),
	},
	{
		"section": "video",
		"key": "fullscreen",
		"prop": "fullscreen",
		"type": "bool",
		"default": true,
	},
	{
		"section": "video",
		"key": "fullscreen_width",
		"prop": "fullscreen_width",
		"type": "int",
		"default": 1920,
	},
	{
		"section": "video",
		"key": "fullscreen_height",
		"prop": "fullscreen_height",
		"type": "int",
		"default": 1080,
	},
	{
		"section": "video",
		"key": "render_scale",
		"prop": "render_scale",
		"type": "float",
		"default": 1.0,
	},
	{
		"section": "video",
		"key": "show_fps",
		"prop": "show_fps",
		"type": "bool",
		"default": true,
	},
	{
		"section": "input",
		"key": "sensitivity",
		"prop": "sensitivity",
		"type": "float",
		"default": 1.0,
	},
	{
		"section": "audio",
		"key": "master_volume",
		"prop": "master_volume",
		"type": "float",
		"default": 1.0,
	},
]

# Variables used by the rest of the project.
var bg_c: Color
var bg2_c: Color
var bg3_c: Color
var bg4_c: Color

var fg_c: Color
var fg2_c: Color

var sensitivity: float

var fullscreen: bool
var fullscreen_width: int
var fullscreen_height: int
var render_scale: float 
var show_fps: bool

var master_volume: float

const default_font_size = 16 
const main_font = preload("res://assets/fonts/JetBrainsMono-Bold.ttf")
const bold_font = preload("res://assets/fonts/JetBrainsMono-ExtraBold.ttf")
const light_font = preload("res://assets/fonts/JetBrainsMono-SemiBoldItalic.ttf")


func _ready() -> void:
	print("[Config_main] Start: ", Time.get_ticks_msec())
	ConfigManager.load_config(CONFIG_FILE_NAME, SETTINGS, self)
	
	if fullscreen:
		DisplayServer.window_set_mode(DisplayServer.WINDOW_MODE_EXCLUSIVE_FULLSCREEN)
		get_viewport().content_scale_aspect = Window.CONTENT_SCALE_ASPECT_IGNORE
		get_viewport().set_scaling_3d_scale(render_scale)
		
	else:
		DisplayServer.window_set_mode(DisplayServer.WINDOW_MODE_WINDOWED)
	
	AudioServer.set_bus_volume_db(
	AudioServer.get_bus_index("Master"),
	linear_to_db(master_volume)
	)
	
	RenderingServer.set_default_clear_color(self.bg3_c)
	
	print("[Config_main] End: ", Time.get_ticks_msec())
	
