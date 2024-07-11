extends CharacterBody3D
#Mouse
const mouse_sens = 0.2
#Speed
var target_speed = 0.0
var current_speed = 0.0
#Directional movement input values
var lerp_speed =  9.0
var curr_dir = Vector3.ZERO
var input_dir = Vector2.ZERO
#Capsule height, crouch and crawldepth
const height = 1.8
var target_height = 1.8
var crouch_depth = -0.65
var crawl_depth = -1.3

var gravity = 11.0

var inventory_open = false

@onready var head := $Head
@onready var standing_capsule := $StandingCapsule
@onready var crouching_capsule := $CrouchingCapsule
@onready var crawling_capsule := $CrawlingCapsule
@onready var standing_cast = $StandingCast
@onready var crouching_cast = $CrouchingCast
@onready var pickup_cast = $PickupCast
@onready var player_inventory = $PlayerInventory



func _ready():
	Input.set_mouse_mode(Input.MOUSE_MODE_CAPTURED)
	
func _input(event):
	if event is InputEventMouseMotion and inventory_open == false:
		rotate_y(deg_to_rad(-event.relative.x * mouse_sens))
		head.rotate_x(deg_to_rad(-event.relative.y * mouse_sens))
		head.rotation.x = clamp(head.rotation.x,-(PI/2.0), PI/2.0,)
	

func _physics_process(delta):
	if inventory_open == false:
		curr_dir = lerp(curr_dir, transform.basis * 
				Vector3(input_dir.x, 0, input_dir.y).normalized(), delta * lerp_speed)
				
		velocity.x = curr_dir.x * target_speed
		velocity.z = curr_dir.z * target_speed
	else:
		if is_on_floor():
			velocity.x = 0.0
			velocity.z = 0.0
	move_and_slide()
