extends StaticBody3D

@export var health = 1

func hit(damage : int):
	health -= damage
	if health <= 0:
		queue_free()
