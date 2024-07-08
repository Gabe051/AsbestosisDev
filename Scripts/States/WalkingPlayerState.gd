class_name WalkingPlayerState

extends State

@onready var player := $"../.."



func enter() -> void:
	player.target_speed = 6.0
	
	
func exit() -> void:
	pass

func physics_update(delta : float) -> void:
	player.curr_dir = lerp(player.curr_dir, player.transform.basis * 
			Vector3(player.input_dir.x, 0, player.input_dir.y).normalized(), delta * player.lerp_speed)
			
	player.velocity = player.curr_dir * player.target_speed
	
func update(delta : float) -> void:
	player.input_dir = Input.get_vector("left","right", "forward", "backward")
	if player.input_dir == Vector2.ZERO:
		transition.emit("IdlePlayerState")
	
	if Input.is_action_pressed("sprint"):
		transition.emit("SprintingPlayerState")
		

func handle_input(event) -> void:
	pass
