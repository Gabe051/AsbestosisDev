class_name FallingPlayerState

extends State

@onready var player := $"../.."

func enter() -> void:
	player.target_speed = clamp(player.target_speed - 1.0, 1.0, 10.0) #clamp it incase this could be exploited through several
																	#transitions somehow
	pass
	
func exit() -> void:
	pass
	
func update(delta : float) -> void:
	# IMPLEMENT MILD AIR STRAFE NEXT
	pass
	
func physics_update(delta : float) -> void:
	if player.is_on_floor():
		transition.emit("IdlePlayerState")
	else:
		player.velocity.y -= player.gravity * delta
	
func handle_input(event) -> void:
	pass
