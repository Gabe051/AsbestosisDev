class_name Inventory

extends Control

var inventory_capacity := 12
var item_count = 0
var inventory = []


@onready var player = $".."
@onready var grid_container = $Background/GridContainer
@onready var drag_icon = $DragIcon

#Item Rearrangement
var item_dragging
var item_held

# Called when the node enters the scene tree for the first time.
func _ready():
	inventory.resize(12)
	populate_grid()

# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(delta):
	if item_dragging:
		var pos = get_global_mouse_position()
		drag_icon.position.x = pos.x - drag_icon.size.x / 2
		drag_icon.position.y = pos.y - drag_icon.size.y / 2
	
func open_close():
	if !player.is_in_inventory:
		self.show()
		player.is_in_inventory = true
		Input.set_mouse_mode(Input.MOUSE_MODE_VISIBLE)
	else:
		if item_dragging:
			add_item(item_dragging)
			drag_icon.texture = null
			drag_icon.hide()
			item_dragging = null
		self.hide()
		player.is_in_inventory = false
		Input.set_mouse_mode(Input.MOUSE_MODE_CAPTURED)
		
func populate_grid():
	for i in inventory_capacity:
		var slot_scene = ResourceLoader.load("res://Scenes/User Interface/InventorySlot.tscn")
		var button_slot = slot_scene.instantiate()
		var button_slot_button = button_slot.get_node("InventoryButton")
		button_slot_button.connect("OnButtonClick", OnButtonClicked)
		button_slot_button.slot_index = i
		grid_container.add_child(button_slot)
		
func add_item(item : Item):
	#Adds item at the first available spot
	var item_added = false
	for i in inventory.size():
		if !inventory[i] and !item_added:
			#Load item data for inventory
			inventory[i] = item
			#Grab the inventory button slotted to, update the icon
			var slot = get_grid_slot(i)
			slot.update_item(item)
			item_count += 1
			item_added = true
			#could use break but this is more explicit

func add_item_at(item: Item, index : int):
	inventory[index] = item
	var slot = get_grid_slot(index)
	slot.update_item(item)
	item_count += 1
	
func remove_and_free(index : int):
	var item_to_remove = inventory[index]
	inventory[index] = null
	item_to_remove.queue_free()
	var slot = get_grid_slot(index)
	slot.update_item(null)
	item_count -= 1
	
func remove_item(index : int):
	inventory[index] = null
	var slot = get_grid_slot(index)
	slot.update_item(null)
	item_count -= 1
	
func get_grid_slot(index : int):
	return grid_container.get_child(index).get_node("InventoryButton")

func put_away_item():
	add_item(CustomItemLoader.load_item_to_inventory(item_held))
	item_held.queue_free()
	player.item_being_held = false

func OnButtonClicked(item, index):
	# Consider replacing / refactoring this
	if Input.is_action_just_pressed("item_interact"):
		if !item_dragging and inventory[index]:
			item_dragging = inventory[index]
			remove_item(index)
			item_count -= 1
			drag_icon.texture = item_dragging.texture
			drag_icon.show()
		elif item_dragging and !inventory[index]:
			add_item_at(item_dragging, index)
			item_dragging = null
			item_count += 1
			drag_icon.texture = null
			drag_icon.hide()
		elif item_dragging and inventory[index]:
			var temp_item = inventory[index]
			remove_item(index)
			add_item_at(item_dragging, index)
			item_dragging = temp_item
			drag_icon.texture = item_dragging.texture


	if Input.is_action_just_pressed("use"):
		if inventory[index] and !item_held:
			item_held = CustomItemLoader.load_item_to_hand(inventory[index])
			remove_and_free(index)
			open_close()
			player.hand.add_child(item_held)
			player.item_being_held = true
		elif inventory[index] and item_held:
			var item_put_away = CustomItemLoader.load_item_to_inventory(item_held)
			item_held.queue_free()
			item_held = CustomItemLoader.load_item_to_hand(inventory[index])
			remove_and_free(index)
			player.hand.add_child(item_held)
			player.item_being_held = true
			add_item_at(item_put_away, index)
			open_close()
			
# DELETE LATER
func _on_add_button_test_button_down():
	var battery_item = load("res://Scenes/Items/ItemType/Battery.tscn")
	add_item(CustomItemLoader.load_item_to_inventory(battery_item.instantiate()))
