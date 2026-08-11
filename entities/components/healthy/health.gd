extends Node3D
class_name HealthComponent

signal died(killing_hitter: HitterBox)
#signal took_damage(amount: float, killing_hitter: HitterBox)

@export var hp : float = 100
@export var invincible : bool = false

func damage(hitter: Hitter, amt: float) -> void:
	if !invincible:
		hp -= amt
	
	hitter.target_hit()
	
	if hp <= 0:
		hitter.target_killed()
		
		died.emit(hitter)
		owner.queue_free()
	else:
		hitter.target_hurt()
