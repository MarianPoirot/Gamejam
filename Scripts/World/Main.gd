extends Node


# Called when the node enters the scene tree for the first time.
func _ready():
	pass # Replace with function body.


# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(_delta):
	pass

func _on_player_is_dead():
	if get_tree().change_scene_to_file("res://Scenes/UI/Ending.tscn") != OK:
		print ("Error passing from Main scene to Ending scene")
