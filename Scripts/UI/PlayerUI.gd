extends Control

var _rustyBar;
# Called when the node enters the scene tree for the first time.
func _ready():
	_rustyBar = $RustyBar

# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(delta):
	updateRustyBar(80);
	
func updateRustyBar(health):
	var tween = get_tree().create_tween()
	tween.tween_property(_rustyBar, "value", health, 0.5).set_trans(Tween.TRANS_LINEAR)
