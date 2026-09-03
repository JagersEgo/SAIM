extends Node2D

#func _ready() -> void:
	#ConfigManager.push_notification(ConfigManager.NotificationTypes.NOTICE, "Notifications Display", "Test Notification")
	#ConfigManager.push_notification(ConfigManager.NotificationTypes.NOTICE, "Notifications Display", "Test Notification")
	#ConfigManager.push_notification(ConfigManager.NotificationTypes.NOTICE, "Notifications Display", "Test Notification")
	#ConfigManager.push_notification(ConfigManager.NotificationTypes.NOTICE, "Notifications Display", "Test Notification")

var notifications : Array
var old_hash : int = 0
var new_hash : int = 0

func _physics_process(_delta: float) -> void:
	notifications = ConfigManager.get_notifications()
	new_hash = hash(notifications)
	
	if new_hash == old_hash:
		return
	
	old_hash = new_hash
	
	queue_redraw()

func _draw() -> void:
	var draw_pos := Vector2i.ZERO + Vector2i(0, 1435)
	
	for n in notifications:
		var line = n[1]
		
		## TODO: change color depending on notification type 
		
		draw_string(
			Config.main_font, 
			draw_pos, 
			line, 
			HORIZONTAL_ALIGNMENT_LEFT, 
			-1, 
			Config.default_font_size, 
			Config.fg_c
		)
		
		draw_pos.y -= Config.default_font_size
