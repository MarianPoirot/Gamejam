extends Node

var score : int

# Called when the node enters the scene tree for the first time.
func _ready():
	score = 0

# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(_delta):
	pass

func _on_player_is_dead():
	if get_tree().change_scene_to_file("res://Scenes/UI/Ending.tscn") != OK:
		print ("Error passing from Main scene to Ending scene")

func _on_mob_is_dead():
	score+=1
