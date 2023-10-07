extends Node

@export var base_health = 1000
var health = base_health
var attack=false

# Called when the node enters the scene tree for the first time.
func _ready():
	pass # Replace with function body.


# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(delta):
	$MobBar.value = health
	var r = remap($MobBar.value, 0, 500, 0, 1)
	var g = remap($MobBar.value, 300, 1000, 0, 1)
	var sb = StyleBoxFlat.new()
	$MobBar.add_theme_stylebox_override("fill", sb)
	sb.bg_color = Color(r, g, 0)

func _on_area_2d_area_entered(area):
	attack=true

func _on_area_2d_area_exited(area):
	attack=false
