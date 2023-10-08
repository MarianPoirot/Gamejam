extends CharacterBody2D

class_name Player

signal is_dead
signal gun(Player)

@export var speed_acc : float = 3
@export var max_speed : float = 30
@export var gravity_acc : float = 15
@export var max_gravity : float = 50
@export var jump_acc : float = 5
@export var max_jump : float = 70

var gravity : float
var speed : float
var jump : float = 0
var health = 1000
var direction

var SPEED_RATE :float = 1000

var LastOnGround : float
var maxAirTime = 0.30
var canJumpCut : bool = true
var canJump : bool = true
var isJumping : bool = false

var attack : bool

func _ready():
	LastOnGround = 0
	speed = 0
	direction = 'right'
	attack=false
	$AnimatedSprite2D.play("idle")
	$HitboxAttack1/CollisionHitboxAttack1.set_deferred("disabled",true)
	$HitboxAttack2/CollisionHitboxAttack2.set_deferred("disabled",true)

func _process(delta):
	$Camera2D/PlayerUI.updateRustyBar(health)
	var input =  Input.get_axis("Move_Left", "Move_Right")
	var movement = input * Vector2.RIGHT
	if input != 0 :
		movement = movement.normalized()
		speed += speed_acc
		speed = min(speed, max_speed)
	else:
		speed = 0
	velocity = movement * speed
	if Input.is_action_pressed("Jump") && (canJump or isJumping):
		velocity += Jump()
	
	if is_on_floor():
		canJump = Input.is_action_just_pressed("Jump")
		jump = 200
		gravity = 0
		canJumpCut = true
	else:
		LastOnGround += delta
	
	
	if Input.is_action_just_released("Jump") && canJumpCut:
		canJumpCut = false
		LastOnGround = maxAirTime
		
	if Input.is_action_just_pressed("Jump") && is_on_floor():
		LastOnGround = 0
		isJumping = true;
	
	if Input.is_action_just_pressed("attack1") && not attack:
		self.attack1()
	elif Input.is_action_just_pressed("attack2") && not attack:
		self.attack2()
	elif Input.is_action_just_pressed("attackGun") && not attack:
		self.attackGun()
		
	AddGravity()
	velocity *= delta * SPEED_RATE
	move_and_slide()
	
	if velocity.y > 0:
		canJumpCut = false
		
	if velocity.x>0:
		if direction=="left":
			scale.x*=-1
			$Camera2D.scale.x*=-1
			direction="right"
	elif velocity.x<0:
		if direction=="right":
			scale.x*=-1
			$Camera2D.scale.x*=-1
			direction="left"
		
	if not attack:
		if velocity.x!=0:
			$AnimatedSprite2D.play("move")
		else:
			$AnimatedSprite2D.play("idle")

func AddGravity():
	if is_on_floor():
		gravity = 0
	else:
		gravity += gravity_acc
		gravity = min(gravity, max_gravity)
	velocity += gravity * Vector2.DOWN

func Jump() -> Vector2:
	if LastOnGround > maxAirTime:
		jump = 0
	else:
		jump = max_jump
	return Vector2.UP * jump

func deal_damage(damage):
	health -= damage
	if health<=0:
		die()
		
func die():
	queue_free()
	emit_signal("is_dead")

func knockback(direction2, power):
	global_position.x += direction2.direction_to(self.global_position).x * power

func _on_hurtbox_area_entered(hitbox_area):
	deal_damage(hitbox_area.damage)
	knockback(hitbox_area.global_position,20)

func _on_animated_sprite_2d_animation_finished():
	attack=false
	$HitboxAttack1/CollisionHitboxAttack1.set_deferred("disabled",true)
	$HitboxAttack2/CollisionHitboxAttack2.set_deferred("disabled",true)
	$AnimatedSprite2D.play("idle")

func attack1():
	attack=true
	health-=10
	$HitboxAttack1/CollisionHitboxAttack1.set_deferred("disabled",false)
	$AnimatedSprite2D.play("attack1")
	
func attack2():
	attack=true
	health-=15
	$HitboxAttack2/CollisionHitboxAttack2.set_deferred("disabled",false)
	$AnimatedSprite2D.play("attack2")

func attackGun():
	attack=true
	health-=20
	emit_signal("gun",self)
	$AnimatedSprite2D.play("gun")
