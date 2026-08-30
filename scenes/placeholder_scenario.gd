extends Node

const PATH = "scenario_config/air_angelic.ini"

@onready var target: EnemyTarget = $target
@onready var angelic: Node = $target/angelic_im_movement

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
		"key": "target_radius",
		"prop": "target_radius",
		"type": "float",
		"default": 0.5,
	},
	{
		"section": "target",
		"key": "speed",
		"prop": "speed",
		"type": "float",
		"default": 9.0,
	},
	{
		"section": "target",
		"key": "strafe_interval",
		"prop": "strafe_interval",
		"type": "float",
		"default": 24.0,
	},
	{
		"section": "target",
		"key": "vertical_strength",
		"prop": "vertical_strength",
		"type": "float",
		"default": 1.0,
	},
]

var target_size : float
var target_radius : float
var speed : int
var strafe_interval : float
var vertical_strength : float

func _ready() -> void:
	ConfigManager.load_config(PATH, SETTINGS, self)
	
	angelic.vertical_strength = vertical_strength
	angelic.speed = speed
	angelic.change_interval = strafe_interval
	
	$target.scale = Vector3(target_size,target_size,target_size)
	
	$target/MeshInstance3D.mesh.radius = target_radius
	$target/target/CollisionShape3D2.shape.radius = target_radius

func _input(event: InputEvent) -> void:
	if event.is_action_pressed("reload"):
		#ConfigManager.load_config(PATH, SETTINGS, self)
		self._ready()
		get_viewport().set_input_as_handled()

func query_config() -> Array[Dictionary]:
	return SETTINGS
