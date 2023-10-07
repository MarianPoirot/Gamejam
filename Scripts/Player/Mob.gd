extends CharacterBody2D

signal is_dead
signal is_hurt

@export var base_health = 1000
@export var speed_acc : float = 3
@export var max_speed : float = 25
@export var gravity_acc : float = 15
@export var max_gravity : float = 50

var gravity : float
var speed : float = 0

var health = base_health
var target
var direction = Vector2.ZERO

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
	AddGravity()
	if target:
		direction = global_position.direction_to(target.position)
		speed += speed_acc
		speed = min(speed, max_speed)
		velocity.x += direction.x * speed * delta
	else:
		velocity.x = 0
		speed = 0
	move_and_slide()

func AddGravity():
	if is_on_floor():
		gravity = 0
	else:
		gravity += gravity_acc
		gravity = min(gravity, max_gravity)
	velocity += gravity * Vector2.DOWN
	
func _on_detection_area_body_entered(body):
	target = body

func _on_detection_area_body_exited(body):
	target = null

func deal_damage(damage):
	health -= damage
	if health<=0:
		die()
		
func die():
	queue_free()
	emit_signal("is_dead")

func knockback(direction2, power):
	global_position+= direction2.direction_to(self.global_position) * power

func _on_hurtbox_area_entered(hitbox_area):
	deal_damage(hitbox_area.damage)
	emit_signal("is_hurt")
	print(hitbox_area.damage)
	knockback(hitbox_area.global_position,20)
