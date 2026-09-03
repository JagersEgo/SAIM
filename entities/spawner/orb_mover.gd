extends Node3D

@export var target_limit: int = 6
@export var spawn_variance: Vector3 = Vector3.ZERO
@export var bounds: Vector3 = Vector3.ZERO

@export var SPEED: float = 1.0
@export var MOVE_DIR: Vector3 = Vector3.LEFT
@export var STRAFE_TIME_MAX : float = 1.0
@export var STRAFE_TIME_MIN : float = 1.0
var target_scale : float = 1.0

const STATIC_ORB = preload("res://entities/world/static_orb.tscn")

var strafe_timings : Dictionary[EnemyTarget, float] = {}
var strafe_directions : Dictionary[EnemyTarget, int] = {}

var alive_targets = 0

#func _ready() -> void:
	#for _i in range(target_limit):
		#spawn_target()
	#
	#for child in get_children():
		#var orb := child as EnemyTarget
		#
		#if !strafe_timings.has(orb) || strafe_timings[orb] <= 0:
			#strafe_timings[orb] = randf_range(STRAFE_TIME_MIN, STRAFE_TIME_MAX)
			#strafe_directions[orb] = randi_range(0,1) * 2 - 1

func _process(_delta: float) -> void:
	while alive_targets < target_limit:
		spawn_target()

func _physics_process(delta: float) -> void:
	for child in get_children():
		var orb := child as EnemyTarget
		
		if !strafe_timings.has(orb) || strafe_timings[orb] <= 0:
			strafe_timings[orb] = randf_range(STRAFE_TIME_MIN, STRAFE_TIME_MAX)
			strafe_directions[orb] = randi_range(0,1) * 2 - 1
		
			var new_pos_forward : Vector3 = (orb.position + MOVE_DIR * SPEED * STRAFE_TIME_MAX)
			var new_pos_reverse : Vector3 = (orb.position + MOVE_DIR * SPEED * STRAFE_TIME_MAX * -1)
			
			for i in range(3):
				if bounds[i] == 0: pass
				
				if new_pos_forward[i] > bounds[i] or new_pos_forward[i] < -bounds[i]:
					# OOB in forwards direction
					strafe_directions[orb] = -1  # reverse
					break
				elif new_pos_reverse[i] > bounds[i] or new_pos_reverse[i] < -bounds[i]:
					# OOB in reverse direction
					strafe_directions[orb] = 1  # forward
					break
		
		else:
			strafe_timings[orb] -= delta
		
		orb.global_position += MOVE_DIR * SPEED * strafe_directions[orb] * delta

func spawn_target():
	alive_targets += 1
	var new = STATIC_ORB.instantiate() as EnemyTarget
	self.add_child(new)

	var offset = Vector3(
		randf_range(-spawn_variance.x, spawn_variance.x),
		randf_range(-spawn_variance.y, spawn_variance.y),
		randf_range(-spawn_variance.z, spawn_variance.z)
	)

	new.scale = Vector3(target_scale, target_scale, target_scale)

	new.global_position = self.global_position + offset
	new.destroyed.connect(target_destroyed)

func target_destroyed():
	alive_targets -= 1
