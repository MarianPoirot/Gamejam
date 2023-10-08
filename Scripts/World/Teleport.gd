extends Area2D

@export var player : Node
@export var destination : Node
var teleport : bool 
# Called when the node enters the scene tree for the first time.
func _ready():
	teleport = false


# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(delta):
	if (teleport and Input.is_action_just_pressed("Interact")):
		player.global_position  = destination.global_position
	
func _on_body_entered(body):
	if body is Player:
		teleport = true
	


func _on_body_exited(body):
	if body is Player:
		teleport = false
