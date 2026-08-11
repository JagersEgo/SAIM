extends RayCast3D
class_name HitterCast

@export var hitter : Hitter

func cast(damage: float):
	var target = get_collider() as Target
	
	if target == null:
		return
	
	target.hit_by_cast(self.hitter, damage)
