extends Node2D
class_name TuiScene

@onready var viewport = get_viewport()

@export var width := 256 #52 characters
@export var height := 112
@export var container : TUIContainer
@export var nodes : Array[TuiNode] 
@export var closable : bool = true

var start_font_draw = Vector2i(
	-width + Config.default_font_size*0.5 - 2, 
	-height + Config.default_font_size + 4
)

var RECT := Rect2(Vector2(-width, -height), Vector2(width * 2, height * 2))

@onready var ESCAPE_MAP : Dictionary = {
	'_' : [Config.main_font, Config.fg_c],
	'b' : [Config.bold_font, Config.fg_c],
	'i' : [Config.light_font, Config.fg2_c],
	'l' : [Config.main_font, Config.fg2_c],
}
const NO_MOD = '_'

var last_scene : PackedScene
var selectable_nodes: Array[TuiNode]
var selectable : int = 0
var pointer = 0
var no_draw : bool = false

func _ready() -> void:
	for n: TuiNode in nodes:
		if n.interactable:
			selectable += 1
			selectable_nodes.append(n)

func _unhandled_key_input(event: InputEvent) -> void:
	if Input.is_action_just_pressed("ui_cancel"):
		if closable:
			queue_free()
			
			if last_scene:
				replace(last_scene, true)

	elif Input.is_action_just_pressed("ui_down"):
		pointer += 1
		pointer = pointer % selectable
	elif Input.is_action_just_pressed("ui_up"):
		pointer = (pointer - 1 + selectable) % selectable
	elif Input.is_action_just_pressed("ui_left"):
		selectable_nodes[pointer].hscroll(true)
	elif Input.is_action_just_pressed("ui_right"):
		selectable_nodes[pointer].hscroll(false)
	elif Input.is_action_just_pressed("ui_accept"):
		selectable_nodes[pointer].interact()
	elif event is InputEventKey and event.pressed and not event.echo:
		var n : int = event.keycode - KEY_0

		if n >= 1 and n <= 9:
			if n <= selectable_nodes.size():
				selectable_nodes[n - 1].interact()

	
	viewport.set_input_as_handled()
	queue_redraw()

func get_selected_node() -> TuiNode:
	if pointer > len(selectable_nodes) - 1: return null
	return selectable_nodes[pointer]

func _draw() -> void:
	if no_draw:
		return
	
	var draw_location : Vector2i = start_font_draw
	
	draw_rect(RECT, Config.bg_c)
	
	for i in range(len(nodes)):
		var n: TuiNode = nodes[i]
		
		var selected = get_selected_node() == n
		var text := n.body(get_selected_node() == n)
		
		for line in text:
			if selected: render_selection_bar(draw_location)
			
			var line_types := {}
			var active_mod = NO_MOD
			
			for key in ESCAPE_MAP.keys():
				line_types[key] = ""
			
			var _simulated_index := 0 # idx in line with no escapes
			var line_idx := 0
			while line_idx < len(line):
				var character := line[line_idx]
				
				if character == '\\':
					var escape := line[line_idx + 1]
					
					if ESCAPE_MAP.has(escape):
						if active_mod == escape:
							active_mod = NO_MOD
						else:
							active_mod = escape
						
						# Skip over escaped character
						line_idx += 2
					else:
						push_error("Unrecognised escape in: ", line, character)
						line_idx += 1
						
					continue
				
				for k in line_types.keys():
					if k == active_mod: continue
					line_types[k] += ' '
				line_types[active_mod] += line[line_idx]
				
				line_idx += 1
				_simulated_index += 1
				
			for key in line_types.keys():
				if (line_types[key] as String).replace(' ', '') == "": continue
				render_line(selected, line_types[key], draw_location, ESCAPE_MAP[key][0], ESCAPE_MAP[key][1])
			
			draw_location.y += Config.default_font_size * 1.2

func render_selection_bar(draw_location: Vector2i):
	draw_string(
		Config.main_font,
		draw_location, 
		#"█████████████████", 
		"███████████████████████████████████████████████████", 
		HORIZONTAL_ALIGNMENT_LEFT, 
		-1, 
		Config.default_font_size, 
		Config.fg_c
	)
	draw_string(
		Config.main_font,
		draw_location + Vector2i(Config.default_font_size/2, 0),
		#"████████████████", 
		"███████████████████████████████████████████████████", 
		HORIZONTAL_ALIGNMENT_LEFT, 
		-1, 
		Config.default_font_size, 
		Config.fg_c
	)

func render_line(selected: bool, line: String, draw_location: Vector2i, font: Font, color: Color):
	if selected:
		draw_string(
			font,
			draw_location, 
			line, 
			HORIZONTAL_ALIGNMENT_LEFT, 
			-1, 
			Config.default_font_size, 
			Config.bg_c
		)
	else:
		draw_string(
			font,
			draw_location, 
			line, 
			HORIZONTAL_ALIGNMENT_LEFT, 
			-1, 
			Config.default_font_size, 
			color
		)

func replace(scene: PackedScene, is_last: bool = false):
	var new_scene = scene.instantiate() as TuiScene
	new_scene.container = container
	
	if !is_last:
		var self_scene = PackedScene.new()
		self_scene.pack(self)
		
		new_scene.last_scene = self_scene
	
	container.add_child(new_scene)
	
	queue_free()

func kill_self():
	if last_scene:
		replace(last_scene)

func adopt(scene: Node):	
	no_draw = true
	self.process_mode = Node.PROCESS_MODE_DISABLED
	
	scene.process_mode = Node.PROCESS_MODE_ALWAYS
	
	scene.tree_exited.connect(self.reenable)
	add_child(scene)
	
	self.queue_redraw()

func reenable():
	no_draw = false
	self.process_mode = Node.PROCESS_MODE_ALWAYS
	
	self.queue_redraw()

func nodes_were_updated():
	selectable = 0
	selectable_nodes = []
	self._ready()
