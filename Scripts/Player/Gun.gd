extends Node

var direction
@export var damage = 300

func _ready():
	direction = 'left'
	$AnimatedSprite2D.hide()
	$CollisionShape2D.set_deferred("disabled",true)

func _on_player_gun(player):
	self.position=player.position
	if player.direction=="left":
		if player.direction!= direction :
			self.scale.x*=-1
			direction='left'
		self.position.x -= 25
	else:
		if player.direction!= direction :
			self.scale.x*=-1
			direction='right'
		self.position.x += 25
	$CollisionShape2D.set_deferred("disabled",false)
	$AnimatedSprite2D.show()
	$AnimatedSprite2D.play("default")

func _on_animated_sprite_2d_animation_finished():
	$CollisionShape2D.set_deferred("disabled",true)
	$AnimatedSprite2D.hide()
