class_name CrouchingPlayerState

extends State

@onready var player := $"../.."

var crouch_transition : bool = false

func enter() -> void:
	#Adjust player height and speed
	player.target_speed = 3.5
	player.target_height = player.height + player.crouch_depth
	crouch_transition = true
	player.standing_capsule.set_disabled(true)
	player.crouching_capsule.set_disabled(false)
	
func exit() -> void:
	player.target_height = player.height
	crouch_transition = true
	player.standing_capsule.set_disabled(false)
	player.crouching_capsule.set_disabled(true)
	
	
func _process(delta):
	# this needs to be separated from the update function because it needs to perform the transition animation
	# whilst there is a different current state
	#Utilise the process function to lerp the transition between crouches
	if(crouch_transition):
		player.head.position.y = lerp(player.head.position.y, player.target_height, 5.0 * delta)
		if player.head.position.y == player.target_height:
			crouch_transition = false
	pass

func update(delta : float) -> void:
	
	player.input_dir = Input.get_vector("left","right", "forward", "backward")
	
	if Input.is_action_just_pressed("crouch") and !player.standing_cast.is_colliding():
		crouch_transition = true
		transition.emit("IdlePlayerState")
		
	if Input.is_action_just_pressed("crawl"):
		crouch_transition = false #Ensure that only crawl or crouch transition plays at a time
		transition.emit("CrawlingPlayerState")
		
	pass
	
func physics_update(delta : float) -> void:
	if not player.is_on_floor():
		transition.emit("FallingPlayerState")
	
func handle_input(event) -> void:
	pass
	
