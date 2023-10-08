extends Node

func _ready():
	update_score(Variables.score)
	$EndAudio.play()

func _physics_process(_delta):
	if Input.is_action_pressed("start"):
		_on_restart_button_down()
	if Input.is_action_pressed("quit"):
		_on_quit_button_down()

func update_score(score):
	$Score.text = "Score: " + str(score)

func _on_restart_button_down():
	$EndAudio.stop()
	if get_tree().change_scene_to_file("res://Scenes/World/Main.tscn") != OK:
		print ("Error passing from Opening scene to main scene")

func _on_quit_button_down():
	get_tree().quit()
