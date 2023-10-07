extends CharacterBody2D

class_name Player

@export var speed_acc : float = 3
@export var max_speed : float = 30
@export var gravity_acc : float = 15
@export var max_gravity : float = 50
@export var jump_acc : float = 5
@export var max_jump : float = 70

var gravity : float
var speed : float
var jump : float = 0

var SPEED_RATE :float = 1000

var LastOnGround : float
var maxAirTime = 0.30
var canJumpCut : bool = true
var canJump : bool = true
var isJumping : bool = false

func _ready():
	LastOnGround = 0
	speed = 0

func _process(delta):
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
	AddGravity()
	
	if velocity.y > 0:
		canJumpCut = false
		
	velocity *= delta * SPEED_RATE
	move_and_slide()

func _physics_process(delta):
	pass

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
