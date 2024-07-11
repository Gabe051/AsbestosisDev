class_name PlayerInventory

extends Node

@onready var player = $".."
@onready var inventory_ui = $InventoryUI
@onready var inventory_graphics = $InventoryUI/ColorRect/InventoryUi

const max_items = 12
const row_count = 4
const col_count = 3
var item_count = 0
var inventory = []

var held_item

func _process(delta):
	if Input.is_action_just_pressed("inventory"):
		if player.inventory_open == false:
			for item in inventory:
				print(item)
			inventory_ui.show()
			player.inventory_open = true
		else:
			#ADD CHECK FOR HOLDING AN ITEM UP SO DOESNT DISAPPEAR
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
		if inventory[slot.index] and !held_item:
			var texture_copy = slot.texture_rect.texture
			held_item = inventory[slot.index]
			slot.texture_rect.set_texture(null)
			inventory_graphics.set_item_held(texture_copy)
			
			
		elif inventory[slot.index] and held_item:
			var temp_item = inventory[slot.index]
			var temp_tex = slot.texture_rect.texture
			inventory[slot.index] = held_item
			slot.update_texture(inventory_graphics.mouse_drag_rect.texture)
			held_item = temp_item
			inventory_graphics.mouse_drag_rect.texture = temp_tex
		if !inventory[slot.index] and held_item:
			inventory[slot.index] = held_item
			slot.update_texture(inventory_graphics.mouse_drag_rect.texture)
			held_item = null
			inventory_graphics.mouse_drag_rect.texture = null
		
# Called when the node enters the scene tree for the first time.
func _ready():
	inventory.resize(12)
	

