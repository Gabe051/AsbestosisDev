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

#Head Pivot
@onready var head := $Head

#Collision Capsules
@onready var standing_capsule := $StandingCapsule
@onready var crouching_capsule := $CrouchingCapsule
@onready var crawling_capsule := $CrawlingCapsule
#Raycasts
@onready var standing_cast = $StandingCast
@onready var crouching_cast = $CrouchingCast
@onready var pickup_cast = $Head/PickupCast


#Inventory
var is_in_inventory = false
@onready var inventory = $Inventory

var highlighted_objects = []


func _ready():
	Input.set_mouse_mode(Input.MOUSE_MODE_CAPTURED)
	
func _process(delta):
	
	check_item_highlight()
	
	if Input.is_action_just_pressed("inventory"):
		inventory.open_close()
	if Input.is_action_just_pressed("item_interact") and !is_in_inventory:
		if pickup_cast.get_collider() is GroundItem:
			var item_clicked = pickup_cast.get_collider()
			if inventory.item_count < inventory.inventory_capacity:
				highlighted_objects = []
				inventory.add_item(CustomItemLoader.load_item_to_inventory(item_clicked))
				item_clicked.queue_free()
				
func _input(event):
	if event is InputEventMouseMotion and !is_in_inventory:
		rotate_y(deg_to_rad(-event.relative.x * mouse_sens))
		head.rotate_x(deg_to_rad(-event.relative.y * mouse_sens))
		head.rotation.x = clamp(head.rotation.x,-(PI/2.0), PI/2.0,)

func _physics_process(delta):
	
	if !is_in_inventory:
		curr_dir = lerp(curr_dir, transform.basis * 
				Vector3(input_dir.x, 0, input_dir.y).normalized(), delta * lerp_speed)
					
		velocity.x = curr_dir.x * target_speed
		velocity.z = curr_dir.z * target_speed
	elif is_on_floor():
		velocity.x = 0
		velocity.z = 0
	move_and_slide()

func check_item_highlight():
	if highlighted_objects.size() > 0:
		for item in highlighted_objects:
			if pickup_cast.get_collider() != item:
				item.outline.hide()
	
	if pickup_cast.is_colliding() and pickup_cast.get_collider() is GroundItem:
		if !pickup_cast.get_collider().outline.is_visible():
			pickup_cast.get_collider().outline.show()
			highlighted_objects.append(pickup_cast.get_collider())
	
	
