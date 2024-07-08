class_name IdlePlayerState

extends State

@onready var player := $"../.."

func enter() -> void:
	print("Idle")
	
func exit() -> void:
	pass
	
func update(delta : float) -> void:
	if Input.is_action_pressed("forward"):
		transition.emit("WalkingPlayerState")
	
func physics_update(delta : float) -> void:
	pass
	
func handle_input(event) -> void:
	pass
