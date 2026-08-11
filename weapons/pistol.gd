extends Node3D

signal shoot(damage: float)
signal got_kill
signal got_a_hurt
signal got_a_hit

# --- CONFIGURABLE VARIABLES ---
var cycle_time: float = 0.0  # Time between shots in seconds
@export var damage : float = 100

# --- INTERNAL STATE ---
var _time_since_last_shot: float = 0.0

func _process(delta: float) -> void:
	_time_since_last_shot += delta

func try_shoot():
	if _time_since_last_shot >= cycle_time:
		_time_since_last_shot = 0
		#print("bang")
		shoot.emit(damage)

func kill():
	got_kill.emit()

func hurt():
	got_a_hurt.emit()

func hit():
	got_a_hit.emit()
