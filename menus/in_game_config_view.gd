extends TuiScene

@export var tui_config_display: TuiConfigDisplay

func parse(entries) -> void:
	tui_config_display.parse(entries)
	
	self.update_height(2 + len(tui_config_display.body(false)))
	#print(self.height)
	#print(len(tui_config_display.body(false)))

func _on_tui_centre_button_pressed() -> void:
	self.queue_free()
