class_name InInventoryState

extends State

@onready var player = $"."
@onready var item_state_machine = $".."
@onready var player_inventory = $"../../PlayerInventory"


func enter() -> void:
	Input.set_mouse_mode(Input.MOUSE_MODE_VISIBLE)
	
func exit() -> void:
	Input.set_mouse_mode(Input.MOUSE_MODE_CAPTURED)
	item_state_machine.previous_state = item_state_machine.current_state
	
func update(delta : float) -> void:
	if Input.is_action_just_pressed("inventory"):
		transition.emit(item_state_machine.previous_state.name)
		
func item_being_held():
	transition.emit("ItemHeldState")

func item_selected():
	pass


func physics_update(delta : float) -> void:
	pass
	
func handle_input(event) -> void:
	pass
