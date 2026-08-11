extends Node2D

@export var pause_menu : Node
@export var game_scene : Node3D

var paused := false

func _ready() -> void:
	pause()
	
	print("FIX TEMP CONFIG DISPLAY")
	$TuiScene/TuiConfigDisplay.parse(game_scene.query_config())

func _input(event: InputEvent) -> void:
	if event.is_action_pressed("ui_close_dialog"):
		paused = !paused
		pause()
		get_viewport().set_input_as_handled()

func _on_tui_button_5_pressed() -> void:
	print("pressed")
	paused = !paused
	pause()
	
func bind_scenario(scenario: PackedScene):
	var i := scenario.instantiate()
	self.add_child(i)
	self.game_scene = i

func pause():
	print("[in_game] Pause: ", paused)
		
	if paused:
		game_scene.process_mode = Node.PROCESS_MODE_DISABLED
		#game_scene.visible = false
		
		pause_menu.process_mode = Node.PROCESS_MODE_ALWAYS
		pause_menu.visible = true
	else:
		game_scene.process_mode = Node.PROCESS_MODE_ALWAYS
		#game_scene.visible = true
		
		pause_menu.process_mode = Node.PROCESS_MODE_DISABLED
		pause_menu.visible = false
	
	pause_menu.queue_redraw()

func _on_tui_button_6_pressed() -> void:
	Input.set_mouse_mode(Input.MOUSE_MODE_VISIBLE)
	queue_free()


func _on_tui_centre_button_4_pressed() -> void:
	get_tree().quit()
