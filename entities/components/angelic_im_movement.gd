extends Node3D

@export var body : RigidBody3D

@export var speed : float
@export var accel : float
@export var change_interval : int = 24
@export var vertical_strength : float = 0.0

@export var orbit_centre : Vector3 = Vector3.ZERO
@export var radius : float = 60
@export var min_radius : float = 10

@onready var MOVEMENT_VEC = Vector3.FORWARD * speed

var ticker := 0

var old_direction : Vector3 = Vector3.ZERO
var new_direction : Vector3 = Vector3.ZERO

func _ready() -> void:
	old_direction = get_new_direction()
	new_direction = get_new_direction()

func _physics_process(_delta: float) -> void:
	if ticker == change_interval:
		ticker = 0
		old_direction = new_direction
		new_direction = get_new_direction()
	
	ticker += 1

	body.linear_velocity = old_direction.lerp(new_direction, float(ticker)/change_interval) * speed

func get_new_direction() -> Vector3:
	#var new : Vector3 = MOVEMENT_VEC.rotated(Vector3.DOWN, get_random_angle_radians())
	var new : Vector3 = get_random_direction_3d()
	
	if (orbit_centre.distance_to(body.position + new * speed) > radius):
		#new = -new
		
		var to_center = (orbit_centre - body.position).normalized()
		new = new.lerp(to_center, 0.5).normalized()
	
	elif (orbit_centre.distance_to(body.position + new * speed) < min_radius):
		var rev_to_center = -(orbit_centre - body.position).normalized()
		new = new.lerp(rev_to_center, 0.5).normalized()
	
	
	new.y *= vertical_strength
	new = new.normalized()
	
	return new

func get_random_angle_radians() -> float:
	return randf() * TAU
	
func get_random_direction_3d() -> Vector3:
	var theta = randf() * TAU        # full rotation around Y axis
	var phi = acos(2.0 * randf() - 1.0)  # inclination from Z axis

	var x = sin(phi) * cos(theta)
	var y = cos(phi)
	var z = sin(phi) * sin(theta)

	return Vector3(x, y, z).normalized()
