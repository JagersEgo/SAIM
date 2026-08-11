extends Node3D

@export var body : CharacterBody3D

const SPEED = 10
const JUMP_VELOCITY = 5

func move(map: Vector2, mod1: bool, _mod2: bool):
	var delta = get_physics_process_delta_time()
	
	if not body.is_on_floor():
		body.velocity += body.get_gravity() * delta

	if mod1 and body.is_on_floor():
		body.velocity.y = JUMP_VELOCITY

	map = map.rotated(-body.rotation.y)
	var direction := (transform.basis * Vector3(map.x, 0, map.y)).normalized()
	if direction:
		body.velocity.x = direction.x * SPEED
		body.velocity.z = direction.z * SPEED
	else:
		body.velocity.x = move_toward(body.velocity.x, 0, SPEED)
		body.velocity.z = move_toward(body.velocity.z, 0, SPEED)

	body.move_and_slide()
