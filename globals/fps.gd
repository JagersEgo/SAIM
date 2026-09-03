extends Node2D

func _ready() -> void:
	await get_tree().process_frame
	
	if !Config.show_fps:
		queue_free()

func _physics_process(_delta: float) -> void:
	queue_redraw()

func _draw() -> void:
	var line : String = \
	"FPS: " + str(Engine.get_frames_per_second()) + \
	" | frametime: " + "%.2f"%(1000.0 / Engine.get_frames_per_second()) + \
	" | " +  RenderingServer.get_current_rendering_driver_name() + \
	" | " + DisplayServer.get_name() #+ \
	#" | resolution: " + str(get_viewport().get_visible_rect().size) + " => " + \
	#str(DisplayServer.screen_get_size())
	
	
	draw_string(
		Config.main_font, 
		Vector2i.ZERO + Vector2i(0, Config.default_font_size), 
		line, 
		HORIZONTAL_ALIGNMENT_LEFT, 
		-1, 
		Config.default_font_size, 
		Config.fg_c
	)
