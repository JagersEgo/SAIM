extends RigidBody3D
class_name EnemyTarget

signal destroyed

func on_killed(_killing_hitter: Hitter):
	destroyed.emit()
