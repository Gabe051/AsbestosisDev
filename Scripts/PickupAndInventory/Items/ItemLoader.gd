class_name ItemLoader

extends Node

#PUT RESOURCE TO ID IN EACH OF 3 DICTIONARIES
#@onready var item_resource = load(path_to_item_in_inventory)
#@onready var ground_item_resource = load(path_to_item_on_ground)
#@onready var held_item_resource = load(path_to_item_on_ground

@onready var item_dictionary : Dictionary
@onready var ground_item_dictionary : Dictionary
@onready var held_item_dictionary : Dictionary


func load_item_to_inventory(item) -> Item:
	return item_dictionary[item.ID].instantiate()
	
func load_item_to_ground(item) -> GroundItem:
	return item_dictionary[item.ID].instantiate()
	

func load_item_to_hand(item) -> HeldItem:
	#match ID
	return null

func _ready():
	item_dictionary[ItemEnum.ItemID.BATTERY] = load("res://Scenes/Items/ItemType/Battery.tscn")
	ground_item_dictionary[ItemEnum.ItemID.BATTERY] = load("res://Scenes/Items/GroundItem/GroundBattery.tscn")
	pass
