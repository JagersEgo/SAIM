extends Area3D
class_name Target

signal got_hit(hitter: Hitter, damage: float)

func hit_by_hitterbox(area: Hitter, damage: float) -> void:
	got_hit.emit(area, damage)

func hit_by_cast(cast: Hitter, damage: float) -> void:
	#print("Hit by cast")
	got_hit.emit(cast, damage)
