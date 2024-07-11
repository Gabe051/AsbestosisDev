class_name EmptyHandedPlayerState

extends State

@onready var player = $"../.."
@onready var item_state_machine = $".."
@onready var pickup_cast = $"../../Head/PickupCast"
@onready var player_inventory = $"../../PlayerInventory"
@onready var inventory_ui = $"../../PlayerInventory/InventoryUI/ColorRect/InventoryUi"
@onready var bag_UI = $"../../PlayerInventory/InventoryUI"

var highlighted_objects = []

func enter() -> void:
	pass
	
func exit() -> void:
	item_state_machine.previous_state = item_state_machine.current_state
	pass
func update(delta : float) -> void:
	if highlighted_objects.size() > 0:
		for item in highlighted_objects:
			if pickup_cast.get_collider() != item:
				item.outline.hide()
	
	if pickup_cast.is_colliding() and pickup_cast.get_collider() is Item:
			if pickup_cast.get_collider().outline.is_visible() == false:
				pickup_cast.get_collider().outline.show()
				highlighted_objects.append(pickup_cast.get_collider())
	
	if Input.is_action_just_pressed("item_interact") and pickup_cast.get_collider() is Item:
		#I think should be able to empty array of highlighted objects on input hopefully upon
		#Item pickup very unlikely other items are highlighted but one
		if player_inventory.item_count < player_inventory.capacity:
			highlighted_objects = []
			player_inventory.add_item(pickup_cast.get_collider())
			#add item
		
		
	if Input.is_action_just_pressed("inventory"):
		Input.set_mouse_mode(Input.MOUSE_MODE_VISIBLE)
		transition.emit("InInventoryState")
		
func physics_update(delta : float) -> void:
	pass
	
func handle_input(event) -> void:
	pass
