extends Node3D

signal shoot(dmg: float)
signal got_kill
signal got_a_hurt
signal got_a_hit

# --- CONFIGURABLE VARIABLES ---
@export var DPS : float = 250

func try_shoot():
	shoot.emit(DPS*get_physics_process_delta_time())

func kill():
	got_kill.emit()

func hurt():
	got_a_hurt.emit()

func hit():
	got_a_hit.emit()
