class_name ItemHeldState

extends State
@onready var player = $"../.."

@onready var player_inventory = $"../../PlayerInventory"
@onready var hand = $"../../Head/Hand"
@onready var item_state_machine = $".."

@onready var held_battery_scene = load("res://Scenes/HeldItems/Held_Battery.tscn")
@onready var held_filter_scene = load("res://Scenes/HeldItems/Held_Filter.tscn")

var item_held
	
func instance_item(item_name):
	match(item_name):
		"battery":
			item_held = held_battery_scene.instantiate()
			hand.add_child(item_held)
		"filter":
			item_held = held_filter_scene.instantiate()
			hand.add_child(item_held)

func enter() -> void:
	pass
	
func exit() -> void:
	item_state_machine.previous_state = item_state_machine.current_state
	
func update(delta : float) -> void:
	
	if !player.inventory_open:
		if Input.is_action_just_pressed("put_away"):
			hand.get_child(0).queue_free()
			transition.emit("EmptyHandedPlayerState")
			item_held = null
		elif Input.is_action_just_pressed("item_interact"):
			#ADD functionality to the held item, return a bool whether consumption was successful
			#to then free the item and remove from inventory
			hand.get_child(0).queue_free()
			player_inventory.item_held_consumed()
			player_inventory.item_count -= 1
			transition.emit("EmptyHandedPlayerState")
			item_held = null
	
	#if Input.is_action_just_pressed("inventory"):
		#Input.set_mouse_mode(Input.MOUSE_MODE_VISIBLE)
		#transition.emit("InInventoryState")
	
func physics_update(delta : float) -> void:
	pass
	
func handle_input(event) -> void:
	pass
