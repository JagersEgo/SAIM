extends Node2D

var shots : int = 0
var hits : int = 0
var kills : int = 0

func add_shot(_damage):
	shots += 1

func add_hit():
	hits += 1

func add_kill():
	kills += 1

func _physics_process(_delta: float) -> void:
	queue_redraw() 

func _draw() -> void:
	draw_string(
		Config.default_font, 
		Vector2i(2400,Config.default_font_size), 
		self.get_accuracy(), 
		HORIZONTAL_ALIGNMENT_RIGHT, 
		160, 
		Config.default_font_size, 
		Config.fg_c
	)
#
#func _input(event: InputEvent) -> void:
	#if event.is_action_pressed("debug"):
		#print(get_accuracy())
		#print("hits: ", hits)
		#print("shots: ", shots)

func get_accuracy() -> String:
	return "%.2f%%" % (float(hits * 100)/shots if shots != 0 else 0.0)
