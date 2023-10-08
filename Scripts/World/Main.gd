extends Node

@export var mob_scene: PackedScene

# Called when the node enters the scene tree for the first time.
func _ready():
	Variables.score = 0
	$AudioStreamPlayer.play()

# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(_delta):
	pass

func _on_player_is_dead():
	$AudioStreamPlayer.stop()
	if get_tree().change_scene_to_file("res://Scenes/UI/Ending.tscn") != OK:
		print ("Error passing from Main scene to Ending scene")

func _on_mob_spawn_timeout():
	var mob = mob_scene.instantiate()
	var mob_spawn_location = get_node("MobPath/MobSpawnLocation")
	mob_spawn_location.progress_ratio = randf()
	mob.position = mob_spawn_location.position
	add_child(mob)

func _on_mob_is_dead():
	Variables.score += 1
