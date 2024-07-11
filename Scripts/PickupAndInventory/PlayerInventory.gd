class_name PlayerInventory

extends Node

@onready var player = $".."
@onready var inventory_ui = $InventoryUI
@onready var inventory_graphics = $InventoryUI/ColorRect/InventoryUi
@onready var in_inventory_state = $"../ItemStateMachine/InInventoryState"
@onready var item_held_state = $"../ItemStateMachine/ItemHeldState"

const capacity = 12
var item_count = 0
var inventory = []

var held_item

var using_item
var using_item_index

func _process(delta):
	if Input.is_action_just_pressed("inventory"):
		if player.inventory_open == false:
			if !item_held_state.item_held:	
				for item in inventory:
					print(item)
				inventory_ui.show()
				player.inventory_open = true
		else:
			if held_item:
				for i in inventory.size(): #Set held item to first free open spot
					if !inventory[i]:
						inventory[i] = held_item
						inventory_graphics.grid_container.get_child(i).texture_rect.texture = inventory_graphics.mouse_drag_rect.texture.duplicate()
						inventory_graphics.set_item_held(null)
						held_item = null
						break
			inventory_ui.hide()
			player.inventory_open = false
	
	if Input.is_action_just_pressed("item_interact"):
		pass
		
	
func add_item(grabbed_item : Item) -> void:
	#Add item to first slot in inventory
	for i in inventory.size():
		if !inventory[i]:
			inventory[i] = grabbed_item.item_name
			inventory_graphics.grid_container.get_child(i).update_texture(grabbed_item.gui_texture)
			break
	item_count += 1
	grabbed_item.queue_free()
	await grabbed_item.tree_exited

func clicked_item(event, slot):
	var slot_ref = inventory_graphics.grid_container.get_child(slot.index)
	if event.get_button_index() == MOUSE_BUTTON_LEFT:
		if inventory[slot.index] and !held_item: #Pickup slotted item to mouse
			pickup_item(slot)
		elif inventory[slot.index] and held_item: #Swap item held with slotted
			var temp_item = inventory[slot.index]
			var temp_tex = slot.texture_rect.texture
			inventory[slot.index] = held_item
			slot.update_texture(inventory_graphics.mouse_drag_rect.texture)
			held_item = temp_item
			inventory_graphics.mouse_drag_rect.texture = temp_tex
			
		elif !inventory[slot.index] and held_item: #Place held item to slot
			inventory[slot.index] = held_item
			slot.update_texture(inventory_graphics.mouse_drag_rect.texture)
			held_item = null
			inventory_graphics.mouse_drag_rect.texture = null
	
	if event.get_button_index() == MOUSE_BUTTON_RIGHT:
		if inventory[slot.index]:
			
			if item_held_state.hand.get_child_count() > 0:
				item_held_state.hand.get_child(0).queue_free()
			
			item_held_state.instance_item(inventory[slot.index])
			in_inventory_state.item_being_held()
			using_item = inventory[slot.index]
			using_item_index = slot.index
			inventory_ui.hide()
			player.inventory_open = false
			
		pass
		
func pickup_item(slot):
	held_item = inventory[slot.index]
	inventory_graphics.set_item_held(slot.texture_rect.texture.duplicate())
	slot.update_texture(null)
	inventory[slot.index] = null
	#update_inventory_array()
	
func item_held_consumed():
	inventory[using_item_index] = null
	inventory_graphics.grid_container.get_child(using_item_index).texture_rect.texture = null
		
	
# Called when the node enters the scene tree for the first time.
func _ready():
	inventory.resize(12)
	
	

	
