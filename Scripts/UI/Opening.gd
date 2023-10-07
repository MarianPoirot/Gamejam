extends Node

func _physics_process(_delta):
	if Input.is_action_pressed("start"):
		_on_start_button_button_down()
	if Input.is_action_pressed("quit"):
		_on_close_button_button_down()

# Called when the node enters the scene tree for the first time.
func _ready():
	pass # Replace with function body.


# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(delta):
	pass


func _on_start_button_button_down():
	pass # Replace with function body.

func _on_close_button_button_down():
	get_tree().quit()

func _on_language_option_button_item_selected(index):
		match index:
			0:
				TranslationServer.set_locale("en")
			1:
				TranslationServer.set_locale("fr")
			2:
				TranslationServer.set_locale("tl")
