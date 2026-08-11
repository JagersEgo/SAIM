extends HumanoidMovementInput

signal update_movement(map: Vector2, movement_mod_1, movement_mod_2)
signal primary_jp()
signal primary_r()
signal primary_h()
signal secondary_jp()
signal secondary_r()
signal secondary_h()
signal middle_jp()
signal middle_r()
signal middle_h()


func _physics_process(_delta: float) -> void:
	movement_map = Input.get_vector("ui_left", "ui_right", "ui_up", "ui_down")
	movement_mod_1 = Input.is_action_just_pressed("jump")
	movement_mod_2 = Input.is_action_just_pressed("crouch")

	update_movement.emit(movement_map, movement_mod_1, movement_mod_2)
	
	if Input.is_action_just_pressed("primary"):
		primary_jp.emit()
	if Input.is_action_just_released("primary"):
		primary_r.emit()
	if Input.is_action_pressed("primary"):
		primary_h.emit()

	if Input.is_action_just_pressed("secondary"):
		secondary_jp.emit()
	if Input.is_action_just_released("secondary"):
		secondary_r.emit()
	if Input.is_action_pressed("secondary"):
		secondary_h.emit()

	if Input.is_action_just_pressed("middle"):
		middle_jp.emit()
	if Input.is_action_just_released("middle"):
		middle_r.emit()
	if Input.is_action_pressed("middle"):
		middle_h.emit()
