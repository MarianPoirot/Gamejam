extends Node2D

class_name Elevator

const IDLE_DURATION=1.0

#aliases
@onready var Elevator=$KinematicElevator

# Variables modifiables dans le main
@export var move_to=Vector2.UP*250 #correspond au y
@export var speed=150
@export var _scale = Vector2(2.5, 0.5) #taille de notre ascenceur

var follow=Vector2.ZERO

# Called when the node enters the scene tree for the first time.
func _ready():
	set_scale(_scale)
	_init_tween()

func _init_tween():
	var duration=move_to.length()/float(speed)
	var tween = get_tree().create_tween()
	tween.set_loops()
	tween.set_ease(Tween.EASE_IN_OUT)
	tween.tween_property(self,"follow",move_to,duration).from(Vector2.ZERO)
	tween.tween_property(self,"follow",Vector2.ZERO,duration).from(move_to)

func _physics_process(_delta):
	Elevator.position = Elevator.position.lerp(follow,0.075)
