extends Node3D

const PATH = "scenario_config/pokeball.ini"

@onready var orb_spawner: Node3D = $orb_spawner

const SETTINGS := [
	{
		"section": "target",
		"key": "target_size",
		"prop": "target_size",
		"type": "float",
		"default": 1.0,
	},
	{
		"section": "target",
		"key": "target_limit",
		"prop": "target_limit",
		"type": "int",
		"default": 6,
	},
	{
		"section": "target",
		"key": "x_variance",
		"prop": "x_variance",
		"type": "float",
		"default": 30.0,
	},
	{
		"section": "target",
		"key": "y_variance",
		"prop": "y_variance",
		"type": "float",
		"default": 30.0,
	},
	{
		"section": "target",
		"key": "z_variance",
		"prop": "z_variance",
		"type": "float",
		"default": 0.0,
	},
]

var target_size : float
var target_limit : int
var x_variance : float
var y_variance : float
var z_variance : float
var orb_scale : float

func _ready() -> void:
	ConfigManager.load_config(PATH, SETTINGS, self)
	
	orb_spawner.orb_scale = target_size
	orb_spawner.target_limit = target_limit
	orb_spawner.x_variance = x_variance
	orb_spawner.y_variance = y_variance
	orb_spawner.z_variance = z_variance

func _input(event: InputEvent) -> void:
	if event.is_action_pressed("reload"):
		ConfigManager.load_config(PATH, SETTINGS, self)
		get_viewport().set_input_as_handled()

func query_config() -> Array[Dictionary]:
	return SETTINGS
