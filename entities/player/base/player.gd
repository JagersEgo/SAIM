extends CharacterBody3D
class_name PlayerCharacter

@onready var head = $head
@onready var ui: CanvasLayer = $ui
@onready var stat_track: Node = $StatTrack

func add_gun(gun: Node3D):
	gun.reparent(head)
	
	gun.connect(gun.shoot, stat_track.add_shot())
	gun.connect(gun.got_a_hurt, stat_track.add_hit())
	gun.connect(gun.got_kill, stat_track.add_kill())
