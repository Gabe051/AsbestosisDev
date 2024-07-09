class_name CrawlingPlayerState

extends State

@onready var player := $"../.."

var crawl_transition : bool = false

func enter() -> void:
	player.target_speed = 2.0
	player.target_height = player.height + player.crawl_depth
	crawl_transition = true
	
func exit() -> void:
	player.target_height = player.height
	crawl_transition = true
	
func _process(delta):
	# this needs to be separated from the update function because it needs to perform the transition animation
	# whilst there is a different current state
	if(crawl_transition == true):
		player.head.position.y = lerp(player.head.position.y, player.target_height, 3.0 * delta)
		if(player.head.position.y == player.height):
			crawl_transition = false
	
func update(delta : float) -> void:
	player.input_dir = Input.get_vector("left","right", "forward", "backward")
	
	if Input.is_action_just_pressed("crawl"):
		transition.emit("IdlePlayerState")
		
	if Input.is_action_just_pressed("crouch"):
		crawl_transition = false #Ensure that only crawl or crouch transition plays at a time
		transition.emit("CrouchingPlayerState")
	
func physics_update(delta : float) -> void:
	if not player.is_on_floor():
		transition.emit("FallingPlayerState")
	
func handle_input(event) -> void:
	pass
