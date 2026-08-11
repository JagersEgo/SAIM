extends Node3D

@export var target_limit = 6
@export var x_variance : float = 30.0
@export var y_variance : float = 30.0
@export var z_variance : float = 0.0
@export var orb_scale : float = 1

const STATIC_ORB = preload("res://entities/world/static_orb.tscn")

var alive_targets = 0

func _process(_delta: float) -> void:
	while alive_targets < target_limit:
		spawn_target()

func spawn_target():
	alive_targets += 1
	var new = STATIC_ORB.instantiate() as EnemyTarget
	new.scale.x = orb_scale
	new.scale.y = orb_scale
	new.scale.z = orb_scale
	
	self.add_child(new)
	
	new.global_position.x = self.global_position.x + randf_range(-x_variance, x_variance)
	new.global_position.y = self.global_position.y + randf_range(-y_variance, y_variance)
	new.global_position.z = self.global_position.z + randf_range(-z_variance, z_variance)
	
	new.destroyed.connect(target_destroyed)

func target_destroyed():
	alive_targets-=1
