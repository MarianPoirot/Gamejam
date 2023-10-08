extends Node

func _ready():
	$CollisionShape2D.set_deferred("disabled",true)

func _process(delta):
	pass


func _on_player_gun(player):
	self.position=player.position
	if player.direction=="left":
		self.position.x -= 10
	else:
		self.scale.x*=-1
		self.position.x += 10
	$CollisionShape2D.set_deferred("disabled",false)
