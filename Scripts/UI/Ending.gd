extends Node


func _physics_process(_delta):
	if Input.is_action_pressed("start"):
		_on_restart_button_down()
	if Input.is_action_pressed("quit"):
		_on_quit_button_down()

# Called when the node enters the scene tree for the first time.
func _ready():
	pass # Replace with function body.


# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(delta):
	pass

func update_score(score):
	$Score.text = "Score: " + str(score)

func _on_restart_button_down():
	pass # Replace with function body.

func _on_quit_button_down():
	get_tree().quit()
