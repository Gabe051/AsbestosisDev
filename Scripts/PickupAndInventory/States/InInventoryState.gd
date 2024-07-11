class_name InInventoryState

extends State

@onready var player = $"."
@onready var item_state_machine = $".."
@onready var player_inventory = $"../../PlayerInventory"


func enter() -> void:
	#var grid = player_inventory.inventory_ui.get_children()
	#for i in 12:
	#	if(player_inventory.inventory[i] != null):
	#		grid[i].label.text = player_inventory.inventory[i]
	#	else:
	#		grid[i].label.text = ""
	
	pass
	
	
func exit() -> void:
	Input.set_mouse_mode(Input.MOUSE_MODE_CAPTURED)
	item_state_machine.previous_state = item_state_machine.current_state
	
	
func update(delta : float) -> void:
	if Input.is_action_just_pressed("inventory"):
		transition.emit(item_state_machine.previous_state.name)
		
	
		
	
func physics_update(delta : float) -> void:
	pass
	
func handle_input(event) -> void:
	pass
