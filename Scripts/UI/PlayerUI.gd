extends Control

var _rustyBar;
@export var health = 1000;

func _physics_process(_delta):
	if Input.is_action_pressed("quit"):
		_on_close_button_button_down()
		
# Called when the node enters the scene tree for the first time.
func _ready():
	_rustyBar = $RustyBar
	updateRustyBar(health);

# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(delta):
	pass
	
func updateRustyBar(health):
	var tween = get_tree().create_tween()
	tween.tween_property(_rustyBar, "value", health, 0.5).set_trans(Tween.TRANS_LINEAR)

func _on_close_button_button_down():
	get_tree().quit()
