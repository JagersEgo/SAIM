extends Area3D
class_name HitterBox

@export var hitter : Hitter

@export var damage: int = 9999

signal hit
signal hurt
signal kill

# agnostic kill/hurt
func target_hit():
	hit.emit()

# hurt but NOT killed
func target_hurt():
	hurt.emit()

# Killed
func target_killed():
	kill.emit()

func _on_area_entered(target: Target) -> void:
	target.hit_by_hitterbox(hitter, damage)
