class_name WalkingPlayerState

extends State

@onready var player := $"../.."

func enter() -> void:
	player.target_speed = 5.0
	
func exit() -> void:
	pass

func physics_update(delta : float) -> void:
	pass
	

func update(delta : float) -> void:
	
	if Input.get_vector("left","right","forward", "backward") == Vector2.ZERO:
		transition.emit("IdlePlayerState")
	
	if Input.is_action_pressed("sprint"):
		transition.emit("SprintingPlayerState")
		

func handle_input(event) -> void:
	pass
