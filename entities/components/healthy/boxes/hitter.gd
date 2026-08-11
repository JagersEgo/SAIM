extends Node3D
class_name Hitter

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
