extends Node

# TODO:
# - Investigate perlin noise / OpenSimplex / fractal Brownian motion (fBm)

# Type 1 config
const max_variation : float = 0.5
const switch_interval : float = 0.2

@onready var key : float = randi_range(1, INT64_MAX)
@onready var base_sensitivity = Config.sensitivity

func _process(delta: float) -> void:
	var seconds := Time.get_ticks_msec() / 1000.0
	var time := seconds * switch_interval
	var wave := sin((frac(time) - 0.5) * PI) / 2 + 0.5 # Sine
	var mult = ((lerp(hash(floor(time*key)), hash(ceil(time*key)), wave))/((2**32)-1)*2)-1  
	
	Config.sensitivity = max(base_sensitivity + (mult * base_sensitivity * max_variation), 0)
	
	#if Engine.get_frames_drawn() % 240 == 0:
		#print(Config.sensitivity)

func frac(x: float) -> float:
	return x - floor(x)
