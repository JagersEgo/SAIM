extends Node2D
class_name TuiScene

const width := 256 #52 characters
const height := 112

var start_font_draw = Vector2i(
	-width + Config.default_font_size*0.5 - 2, 
	-height + Config.default_font_size + 4
)

const RECT := Rect2(Vector2(-width, -height), Vector2(width * 2, height * 2))

@onready var viewport = get_viewport()
@export var container : TUIContainer

@export var nodes : Array[TuiNode] 
@export var closable : bool = true

var last_scene : PackedScene

var selectable_nodes: Array[TuiNode]

var selectable : int
var pointer = 0

var no_draw : bool = false

func _ready() -> void:
	for n: TuiNode in nodes:
		if n.interactable:
			selectable += 1
			selectable_nodes.append(n)

func _unhandled_key_input(_event: InputEvent) -> void:
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
	elif Input.is_action_just_pressed("ui_accept"):
		selectable_nodes[pointer].interact()
	
	viewport.set_input_as_handled()
	queue_redraw()

func get_selected_node() -> TuiNode:
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
			if selected:
				draw_string(
					Config.default_font, 
					draw_location, 
					#"█████████████████", 
					"██████████████████████████████████████████████████", 
					HORIZONTAL_ALIGNMENT_LEFT, 
					-1, 
					Config.default_font_size, 
					Config.fg_c
				)
				draw_string(
					Config.default_font, 
					draw_location + Vector2i(Config.default_font_size/2, 0),
					#"████████████████", 
					"██████████████████████████████████████████████████", 
					HORIZONTAL_ALIGNMENT_LEFT, 
					-1, 
					Config.default_font_size, 
					Config.fg_c
				)
				draw_string(
					Config.default_font, 
					draw_location, 
					line, 
					HORIZONTAL_ALIGNMENT_LEFT, 
					-1, 
					Config.default_font_size, 
					Config.bg_c
				)
			else:
				draw_string(
					Config.default_font, 
					draw_location, 
					line, 
					HORIZONTAL_ALIGNMENT_LEFT, 
					-1, 
					Config.default_font_size, 
					Config.fg_c
				)
			
			draw_location.y += Config.default_font_size * 1.2

func replace(scene: PackedScene, is_last: bool = false):
	var new_scene = scene.instantiate() as TuiScene
	new_scene.container = container
	
	if !is_last:
		var self_scene = PackedScene.new()
		self_scene.pack(self)
		
		new_scene.last_scene = self_scene
	
	container.add_child(new_scene)
	
	queue_free()

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
