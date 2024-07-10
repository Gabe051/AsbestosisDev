class_name WalkingPlayerState

extends State

@onready var player := $"../.."



func enter() -> void:
	player.target_speed = 6.0
	
	
	
	
func exit() -> void:
	pass

func physics_update(delta : float) -> void:
	if not player.is_on_floor():
		transition.emit("FallingPlayerState")
	
func update(delta : float) -> void:
	player.input_dir = Input.get_vector("left","right", "forward", "backward")
	if player.input_dir == Vector2.ZERO:
		transition.emit("IdlePlayerState")
	
	if Input.is_action_just_pressed("crouch"):
		transition.emit("CrouchingPlayerState")
	
	if Input.is_action_pressed("sprint"):
		transition.emit("SprintingPlayerState")
		
	if Input.is_action_just_pressed("crawl"):
		transition.emit("CrawlingPlayerState")
	

func handle_input(event) -> void:
	pass
