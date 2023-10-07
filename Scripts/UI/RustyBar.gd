extends ProgressBar

# Called when the node enters the scene tree for the first time.
func _ready():
	var tween = get_tree().create_tween()
	tween.tween_property(self, "value", 40, 3).set_trans(Tween.TRANS_LINEAR)
