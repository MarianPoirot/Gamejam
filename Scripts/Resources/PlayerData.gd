extends Resource

class_name PlayerData

var gravityStrength : float
var gravityScale : float

@export var fallGravityMult : float
@export var maxFallSpeed : float
@export var fastFallGravityMult : float
@export var maxFastFallSpeed : float

@export var runMaxSpeed : float
@export var runAcceleration : float
var runAccelAmount : float
@export var runDecceleration  : float
var runDeccelAmount : float

@export_range(0,1) var accelInAir : float
@export_range(0,1) var deccelInAir : float

@export var doConserveMomentum : bool = true

@export var jumpHeight : float
@export var jumpTimeToApex : float
var jumpForce : float

@export var jumpCutGravityMult : float
@export_range(0,1) var jumpHangGravityMult : float
@export var jumpHangTimeThreshold : float

@export var jumpHangAccelerationMult : float
@export var jumpHangMaxSpeedMult : float

@export var slideSpeed : float
@export var slideAccel : float

@export_range(0.01,0.05) var coyoteTime : float
@export_range(0.01,0.05) var jumpInputBufferTime : float

func setup():
	gravityStrength = -(2 * jumpHeight) / (jumpTimeToApex * jumpTimeToApex);
	gravityScale = gravityStrength / 9;
	
	runAccelAmount = (50 * runAcceleration) / runMaxSpeed;
	runDeccelAmount = (50 * runDecceleration) / runMaxSpeed;
	
	jumpForce = abs(gravityStrength) * jumpTimeToApex;
