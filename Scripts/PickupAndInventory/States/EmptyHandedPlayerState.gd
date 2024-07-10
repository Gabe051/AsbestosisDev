class_name EmptyHandedPlayerState

extends State

@onready var player = $"../.."


func enter() -> void:
	pass
	
func exit() -> void:
	pass
	
func update(delta : float) -> void:
	if player.pickup_cast.is_colliding():
		if player.pickup_cast.get_collider() is Item:
			pass
		
	
func physics_update(delta : float) -> void:
	pass
	
func handle_input(event) -> void:
	pass
