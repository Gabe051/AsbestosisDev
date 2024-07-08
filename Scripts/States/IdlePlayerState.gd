class_name IdlePlayerState

extends State

@onready var player := $"../.."

func enter() -> void:
	player.target_speed = 0.0
	player.curr_dir = Vector3.ZERO
func exit() -> void:
	pass
	
func update(delta : float) -> void:
	player.velocity = Vector3.ZERO
	if Input.get_vector("left","right","forward", "backward") != Vector2.ZERO:
		transition.emit("WalkingPlayerState")
	
func physics_update(delta : float) -> void:
	pass
	
func handle_input(event) -> void:
	pass
