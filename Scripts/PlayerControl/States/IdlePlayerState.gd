class_name IdlePlayerState

extends State

@onready var player := $"../.."

func enter() -> void:
	player.target_speed = 0.0
	player.curr_dir = Vector3.ZERO
	
	
func exit() -> void:
	pass
	
func update(delta : float) -> void:
	player.velocity.x = 0.0
	player.velocity.z = 0.0
	
	if Input.get_vector("left","right","forward", "backward") != Vector2.ZERO:
		transition.emit("WalkingPlayerState")
	
	if Input.is_action_just_pressed("crouch"):
		transition.emit("CrouchingPlayerState")
		
	if Input.is_action_just_pressed("crawl"):
		transition.emit("CrawlingPlayerState")
	
func physics_update(delta : float) -> void:
	if not player.is_on_floor():
		transition.emit("FallingPlayerState")
	
	
func handle_input(event) -> void:
	pass
